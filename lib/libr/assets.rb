module Libr
	class Assets
		attr_accessor :outputs
		def initialize
			@outputs = {}
		end

		def set_type_output output_type, path
			@outputs[:output_type] = path
		end

		def get filename
			f = AssetElement.new outputs, filename
			f
		end

	end

	class AssetElement
		attr_accessor :filepath
		def initialize outputs, filepath
			@outputs = outputs
			@filepath = filepath
		end
		
		def output_path
			# COPIA o arquivo pra pasta correta, de acordo com os output paths
			# devolve o endereço da cópia
		end
	end
end