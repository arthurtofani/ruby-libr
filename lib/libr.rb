require 'libr/book'
require 'libr/environment'
class Libr
	def isrepo path
		ct = Dir.entries(path).select {|x| x==".librdata"}.count
		return ct>0
	end
	def create_book(name)
		ct = Dir.entries('.').select {|x| x==name}.count
		if ct>0		
			puts "Error: There is a book named `#{name}` in this location"
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

	def create_indexes
		
	end

	def load_plugins path
		script_path = File.expand_path(File.join("#{path}", "envs", @name, "scripts"))
		puts "Loading scripts at #{script_path}"
		arr = Dir[File.join(script_path, "*.rb")]
		arr.each {|file| load File.join(path, "envs", @name, "scripts",  File.basename(file)) }
	end


	def build
		path = "./repotest"		# trocar por "."
		if !isrepo path
			puts "Not a book repo"
			exit(1)
		end

		# start plugins
		load_plugins path


		b = Book.new File.expand_path(path)
		b.load_files
		b.set_ids
		envs_path = File.join(path, "envs")		
		envs = Dir.entries(envs_path).select{|x| x[0]!="."}
		envs.each do |env|
			e = Environment.new(env, b)
		end
		
	end
end



