require 'yaml'
class Environment
	attr_accessor :name, :config

	def initialize(environment_name)
		@name = environment_name
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

	

	
end
