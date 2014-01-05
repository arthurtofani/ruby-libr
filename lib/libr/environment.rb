require 'yaml'
require 'libr/book'
module Libr
	class Environment
		attr_accessor :name, :book_src, :pages
		attr_accessor :build_path, :env_path
		attr_accessor :indexes, :indexes_structure

		def set_default_processor(proc_class)
			@default_processor = proc_class
		end

		def set_method(mtd)
			@runtime_method = mtd
		end

		def set_processor(xmlns, proc_class)
			@processor_dict[xmlns] = proc_class
		end

		def initialize(environment_name, book_source)
			puts "Loading environment #{environment_name}"
			@name = environment_name
			@book_src = book_source
			@pages = []
			@processor_dict = {}
			@default_processor = nil
			@runtime_method = :html
			@indexes_structure = ElementIndexStructure.new 
			load_path
			Processor.cleanup
			load_packages
		end

		# generates an index object/file
		# dom_path		:	A search statement for Hpricot - ex: "section[@type="chapter"]"
		# identifier	:	A symbol to recall indexed elements
		# identifier	:	A symbol to recall indexed elements

		def generate_index (dom_path, identifier, parent)
			
		end

		def load_path
			@env_path = File.expand_path(File.join("#{@book_src.path}", "envs", @name, "scripts"))
		end

		def load_packages
			@script_path = File.expand_path(File.join("#{@book_src.path}", "envs", @name, "scripts"))
			puts "Loading scripts at #{@script_path}"
			arr = Dir[File.join(@script_path, "*.rb")]
			arr.each {|file| load File.join(@book_src.path, "envs", @name, "scripts",  File.basename(file)) }
		end

		def load_config
			begin
				@config = YAML.load_file("./envs/#{@name}.yml")		
			rescue
				puts "Environment not defined"
			end
		end

		def before_process
			yield
		end

		def config
			yield
		end
		def after_process
			yield
		end

		def create_indexes
			@pages.each do |file|
				file_index = @indexes_structure.create_index @page.content, @page.filename
			end
		end

		def process		
			config
			before_process
			after_process
		end	
	end

	class BookPage
		attr_accessor :filename, :content
	end

	class ElementIndexStructure
		attr_accessor :identifier, :pattern, :children, :parent
		def initialize(identifier, pattern, parent)
			@identifier = identifier
			@pattern = pattern
			@parent = parent
			@children = []
		end
		def add_child(element_index, match_identifier)
			if @identifier==match_identifier
				@children.push element_index
			else
				@children.each do |ch|
					ch.add_child element_index, match_identifier
				end
			end
		end

		# está ruim!!!
		def create_index(element, filename, parent_elidx=nil)
			element.search(:pattern).each do |el|
				# TODO: gererate anchor_id
				elidx = Libr::ElementIndex.new filename, anchor_id, el
				parent_elidx.children.push elidx
				@children.each do |ch|		
					create_index(el, filename, elidx)
				end				
			end

		end
	end

	class ElementIndex
		attr_accessor :filename, :anchor_id, :content, :children, 
		def root?
			return @filename.nil?
		end
		def leaf?
			return @children.count==0
		end
		def initialize(filename=nil, anchor_id=nil, content=nil)
			@filename = filename
			@anchor_id = anchor_id
			@content = content
			@children = []
		end
	end
end
