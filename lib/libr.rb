require 'singleton'
require 'libr/book'
require 'libr/environment'
class Libr
	include Singleton
	attr_accessor :environments, :source_book
	def isrepo path
		ct = Dir.entries(path).select {|x| x==".librdata"}.count
		return ct>0
	end

	def current_environments path
		envs_path = File.join(path, "envs")
		Dir.entries(envs_path).select{|x| x[0]!="."}
	end


	# creates a new book repository
	def create_book(name)
		ct = Dir.entries('.').select {|x| x==name}.count
		if ct>0		
			puts "Error: There is already a book named `#{name}` in this location"
		else
			puts "Creating a new book #{name}"
			addr = File.join File.dirname(File.expand_path(__FILE__)), "../vendor/struct.zip"
			system "mkdir #{name}"
			unzip_line = "unzip -q #{addr.to_s} -d ./#{name}"
			puts unzip_line
			system unzip_line
			system "mv ./#{name}/structure/* ./#{name}/"
			system "rm -rf ./#{name}/structure"
			system "mv ./#{name}/librdata ./#{name}/.librdata"
		end
	end

	def create_environment

	end

	def newpage

	end


	def load_packages path
		script_path = File.expand_path(File.join("#{path}", "packages"))
		puts "Loading scripts at #{script_path}"
		arr = Dir[File.join(script_path, "*.rb")]
		arr.each {|file| load File.join(File.expand_path(script_path), File.basename(file)) }
	end

	def build (path, environment=:all)
		path = "./repotest"		# trocar por "."
		if !isrepo path
			puts "Not a book repo"
			exit(1)
		end
		
		# start plugins
		load_packages path
		curr_envs = current_environments path

		# check environments
		envs = nil
		envs = [environment] if curr_envs.include? environment.to_s
		envs = curr_envs if environment==:all
		return if envs = nil

		#load book
		@source_book = Book.new File.expand_path(path)
		@source_book.load_files
		@source_book.set_ids

		#run
		process_environments envs, path
	end

private
	
	def process_environments envs, path
		begin
		envs.each do |env|
			load File.join(File.expand_path(path), "envs", env.to_s, "recipe.rb")
		end
		rescue
			raise "recipe malformed or not available at environment #{env.to_s}"
		end
	end
		
end



