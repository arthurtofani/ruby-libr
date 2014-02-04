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
			@processors = {}
			@assets = Libr::Assets.new
		end

		def set_processor xmlns, output_name
			@processors[xmlns] = output_name.to_s
		end

		def process!
			@output = @doc
			process_namespaces_rec @output.doc
			
		end

		# carrega recursivamente todos os namespaces
		def process_namespaces_rec el
			el.elements.each do |elmt|
				process_namespaces_rec elmt
			end
			str = el.to_s[/xmlns=".*?"/].split("=")[1].gsub("\"", "") rescue nil
			if str
				proc = @processors[str]
				return if proc.nil?

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