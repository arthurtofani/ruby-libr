require 'net/http'
require 'zip/zipfilesystem'
require 'fileutils'
module Libr
	class PackageManager
		@@packages = {}
		@@package_outputs = {}

		def self.register_package pkg			
			@@packages[pkg.get_namespace] = pkg
		end
		def self.register_output pkg_out
			namespace = pkg_out.get_namespace
			@@package_outputs[namespace] = {} if @@package_outputs[namespace].nil?
			@@package_outputs[namespace][pkg_out.get_name.to_s] = pkg_out
		end		

		def self.get_output namespace, package_output
			return @@package_outputs[namespace][package_output.to_s].new
		end

		def get_packages
			return @@packages
		end
		def get_package_outputs namespace
			return @@package_outputs[namespace]
		end		


		attr_accessor :packages, :package_path, :fetch_errors
		def initialize package_path
			@packages = []
			@fetch_errors = []
			@package_path = package_path
		end



		def installed? xmlns
			f = File.join(get_package_path(xmlns), "install.log")
			return File.exist? f
		end

		def create_logfile xmlns
			f = File.join(get_package_path(xmlns), "install.log")
			File.open(f, 'w') {|f| f.write(Time.now.to_s) }
			return File.exist? f
		end

		def get_package_path xmlns
			ns = xmlns
			File.join(@package_path, File.dirname(ns), File.basename(ns, File.extname(ns)))
		end		

		def fetch_package xmlns
			if remote_package_exists? xmlns
				path = package_path xmlns
				FileUtils.mkdir_p path
				filename = File.basename(xmlns)				
				f = open(File.join(path, filename))
				begin
				    http.request_get(xmlns) do |resp|
				        resp.read_body do |segment|
				            f.write(segment)
				        end
				    end
				rescue
					@fetch_errors.push [xmlns, "download_error"]
					return
				ensure
				    f.close()
				end
				begin
					Zip::File.open(filename) do |zipfile|
	  					zipfile.each do |file|
	  						filepath = File.join(path, file)
	    					file.extract(file, filepath)
	  					end
					end
				rescue
					fetch_errors.push [xmlns, "not_zip_file"]
					return
				end
				
				#TODO: ler o manifest...
				if local_package_valid? xmlns
					create_logfile xmlns
				else
					@fetch_errors.push [xmlns, "not_valid"]
				end
				return
			end			
			@fetch_errors.push [xmlns, "not_found"]
		end

		def remote_package_exists? xmlns
			uri = URI(xmlns)
			request = Net::HTTP.new uri.host
			response = request.request_head uri.path
			return response.code.to_i == 200
		end

		def local_package_valid? xmlns
			return true # TODO: validate package
		end

		def rollback_fetch_package xmlns
			FileUtils.rm_rf path
		end

		def load xmlns_list
			load_core_packages

		end		

		def load_package xmlns			
			 f = File.join(get_package_path(xmlns), "*.rb")

			 Dir[f.to_s].each {|file| require file }


			# adiciona o pacote
			
		end

		def update xmlns_list
			# verifica os pacotes q não foram baixados e atualiza
			@fetch_errors = []
			xmlns_list.each do |xmlns|
				fetch_package xmlns if !installed?(xmlns)
			end
			if @fetch_erros.count>0
				fetch_errors.each do |fe|
					puts "Error loading package: #{fe[0].to_s} ; #{fe[1].to_s} " 
					rollback_fetch_package fe[0]
				end
			end
			load xmlns_list
		end

	end
end