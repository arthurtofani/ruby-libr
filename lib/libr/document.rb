require 'nokogiri'
require 'open-uri'
require 'pry'

module Libr
	class Document
		attr_accessor :doc, :package_manager, :namespaces, :environments
		attr_accessor :root_path, :source_path, :assets_path
		
		def initialize root_path=".", source_path="."
			@doc = nil
			@environments = {}
			@root_path = root_path
			@source_path = source_path
			@package_manager = nil
		end


		def load file
			load_file file
			read_include_files
			read_pkg_namespaces
			load_packages
			load_environments			
			#load_packages			
		end


		# carrega o arquivo principal do livro
		def load_file file
			fl = File.join(@source_path, file)
			#puts "Carregando arquivo #{fl.to_s}"
			@doc = Nokogiri::XML(File.open(fl))
		end




		# carrega os pacotes para a memória: os pacotes do CORE e os específicos da aplicação
		def load_packages
			@package_manager = Libr::PackageManager.new(File.join(@root_path, "packages"))	if @package_manager==nil
			@namespaces.each do |ns| 
				@package_manager.load_package ns
			end
		end
		
		# baixa e instala pacotes de dependências
		def update_packages
			@package_manager = Libr::PackageManager.new(File.join(@root_path, "packages"))	if @package_manager==nil
			@package_manager.update @namespaces
		end		

		#private		

		def read_include_files			
			@doc.css("include").each do |incl|
				incl_file = incl.attributes["path"].value
				r = Nokogiri::XML(File.open(File.join(@source_path, incl_file)))
				incl.after r.children
				incl.remove
			end			
		end

		def read_pkg_namespaces				
			tmp = []				
			collect_namespaces(tmp, @doc)
			@namespaces = tmp.uniq
		end
		
		# carrega recursivamente todos os namespaces
		def collect_namespaces arr, el
			nms = el.namespace rescue nil			
			if nms
				arr.push el.namespace.href if !arr.include? el.namespace.href
			end			
			el.elements.each do |elmt|
				collect_namespaces arr, elmt
			end
		end

		def load_environments			
			fld = File.join(@root_path, "env")
			@environments = Dir.entries(fld).select {|f| File.directory?(File.join(fld, f)) && !(f[0]==".") }
		end

		def define_environment name
			env_path = File.join(@root_path, "env", name.to_s)
			Libr::Environment.set_environment @root_path, env_path, @doc, name
		end

		def validate_doc
			validate_doc_rec @doc
		end

private
		def validate_doc_rec el
			el.elements.each do |elmt|
				validate_doc_rec elmt
			end
			str = el.to_s.split(">")[0][/xmlns=".*?"/].split("=")[1].gsub("\"", "") rescue nil
			if str
				cl = package_manager.get_package str
				if cl
					
					cl.new.validate el
				end
			end			
		end		

	end
end

