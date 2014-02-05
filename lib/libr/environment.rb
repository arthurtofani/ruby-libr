module Libr
	class Environment
		@@root_path = ""
		@@path = "" # env path
		@@doc = nil
		def self.set_environment root_path, path, doc_source, name
			@@root_path = root_path
			@@name = name
			@@path = path
			@@doc = doc_source
		end

		def self.start
			env = Libr::Environment.new @@root_path, @@path, @@doc, @@name
			yield env
		end


		# instance methods

		attr_accessor :doc, :path, :processors, :assets, :output, :files, :root_path, :name

		def initialize root_path, path, doc , name
			@root_path = root_path
			@path = path.clone
			@doc = doc
			@name = name			
			@assets = Libr::Assets.new
			@processors = get_default_processors
		end

		def set_processor xmlns, output_name
			new_proc = PackageManager.get_package_outputs(xmlns.to_s)[@name] rescue nil
			@processors[xmlns.to_s] = new_proc if new_proc			
		end

		def get_default_processors
			proc = {}
			PackageManager.get_packages.keys.each do |key|
				deflt = PackageManager.get_package_outputs(key)[@name] rescue nil
				proc[key] = deflt
			end
			proc
		end

		def process!
			@output = @doc.doc
			process_namespaces_rec @output
			
		end

		# carrega recursivamente todos os namespaces
		def process_namespaces_rec el
			el.elements.each do |elmt|
				process_namespaces_rec elmt
			end
			str = el.to_s.split(">").first[/xmlns=".*?"/].split("=")[1].gsub("\"", "") rescue nil
			
			if str
				proc = @processors[str]				
				return if proc.nil?
				begin
				proc.new.convert el
				rescue
					binding.pry
				end

			end			
		end

		def create_file page, hsh
			template = hsh[:template]
			name = hsh[:name]
			# cria o arquivo de saída com base nas infos de entrada
			# cria fisicamente e adiciona referencia ao path na variavel @files
			# @files.push file
		end
	
		# page as a nokogiri dom
		def file_content selector
			# pra cada arquivo em @files (abrir arquivo e ler)
				# pra cada seletor css - nokogiri
					# yield file...
		end

		def get_file filename
			# abre e processa nokogiri, entrega doc
		end

		def add_resource_file resource_type, page, origin_path
			# cria o arquivo de origem na pasta de destino, de acordo com resource_type, 
		end
	end
end