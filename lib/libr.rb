require 'libr/book'
class Libr
	def isrepo
		ct = Dir.entries('.').select {|x| x==".librdata"}.count
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

	def build
		if !isrepo
			puts "Not a book repo"
			exit(1)
		end
		
		b = Book.new File.expand_path(".")
		b.load_files
		b.set_ids
		
	end
end



