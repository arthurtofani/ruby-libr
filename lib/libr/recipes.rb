require 'nokogiri'
module Libr
	class GlobalRecipe
		attr_accessor :doc, :collections
		def initialize
			@collections = {}
		end

		def process environment_list
			pre_process
			environment_list.each do |env|
				env.process
			end
			post_process
		end

		def pre_process

		end

		def post_process

		end


		def create_pre_collection collection_name, collection
			@collections[collection_name] = collection
			#TODO: melhorar
		end
	end

	class EnvironmentRecipe
		attr_accessor :doc, :collections, :output
		def initialize doc
			@doc = doc
			@collections = {}
		end

		def process
			pre_process
			@doc.process
			post_process
		end

		def pre_process

		end

		def post_process

		end


		def create_pre_collection collection_name, collection
			@collections[collection_name] = collection
			#TODO: melhorar
		end
	end	
end