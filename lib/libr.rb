require 'libr/document'
class Libr
	def create_book(name)
		ct = Dir.entries('.').select {|x| x==name}.count
		if ct>0		
			puts "Error: There is a book named `#{name}` in this location"
		else
			puts "Creating a new book #{name}"
			addr = File.join File.dirname(File.expand_path(__FILE__)), "../vendor/struct.zip"
			system "mkdir #{name}"
			unzip_line = "unzip #{addr.to_s} -d ./#{name} -q"
			puts unzip_line
			system unzip_line
			system "mv ./#{name}/structure/* ./#{name}/"
			system "rm -rf ./#{name}/structure"
		end
	end

	def create_environment

	end

	def newpage

	end

	def create_indexes
		
	end

	def build

	end
end



