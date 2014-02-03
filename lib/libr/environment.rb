module Libr
	class Environment
		@@path = ""
		@@doc = nil
		def self.set_environment path, doc_source
			@@path = path
			@@doc = doc_source
		end

		def self.start
			env = Libr::Environment.new @@path, @@doc
			yield env
		end


		# instance methods

		attr_accessor :doc, :path, :processors, :assets, :output, :files

		def initialize path, doc 
			@path = path.clone
			@doc = doc
			@processors = {}
			@assets = Libr::Assets.new
		end

		def set_processor xmlns, output_name
			@processors[xmlns] = output_name.to_s
		end

		def process!
			# faz tudo aqui
			@output = @doc.clone

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