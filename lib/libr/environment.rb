require 'yaml'
class Environment
	attr_accessor :name, :config, :env_path, :book_src, :book_dest

	def initialize(environment_name, book_source)
		@name = environment_name
		@book_src = book_source
		@book_dest = book_source.clone
		load_path
		load_plugins
	end

	def load_path
		@env_path = File.expand(File.join("#{@book_src.path}", "envs", "@name", "scripts"))
	end

	def load_plugins
		
	end

	def load_config
		do
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
