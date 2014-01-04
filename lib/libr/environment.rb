require 'yaml'
require 'libr/processor'
require 'libr/book'

class Environment
	attr_accessor :name, :config, :env_path, :book_src, :book_dest

	def initialize(environment_name, book_source)
		puts "Loading environment #{environment_name}"
		@name = environment_name
		@book_src = book_source
		@book_dest = book_source.clone
		load_path
	end

	# create string with environment path
	def load_path
		@env_path = File.expand_path(File.join("#{@book_src.path}", "envs", @name))
	end


	def load_config
		begin
			@config = YAML.load_file("./envs/#{@name}.yml")		
		rescue
			puts "Environment not defined"
		end
	end

	def save_config
		
	end

	def process
		
	end
	
end
