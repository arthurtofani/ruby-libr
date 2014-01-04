require 'hpricot'

class Book
	attr_accessor :path, :docs
	def initialize(path)
		@path = path
		@docs = []
		@doc = ""

	end

	def load_files
		filelist = Dir.entries("#{@path.to_s}/contents").select {|x| x!="." && x!=".." }.sort!
		filelist = filelist.map {|x| @path + "/contents/" + x }		
		filelist.each {|x| load_file x}
	end

	def load_file(file)
		doc = open(file) { |f| Hpricot(f) }		
		@docs.push ({document: doc, stack: {}})
	end

	def set_ids
		@docs.each do |doc|
			i = 0
			doc[:document].children.each do |ch|
				insert_ids(ch, doc) if i>0
				i+=1
			end
		end
	end

	def insert_ids(el, doc_object)
		if el.class==Hpricot::Elem
			dict_elements[el.name] = [] if dict_elements[el.name].nil?
			dict_elements[el.name].push el
			if el.attributes["id"].empty?
				v = dict_elements[el.name].count
				el.attributes["id"] = el.name + "_" + v.to_s
			end
			if el.name.downcase=="env" && !el.attributes["xmlns"].empty?
				doc_object[:stack].push ({element: el.attributes["id"], parent: el.parent.attributes["id"]})
			end
			chil = el.children rescue nil
			return if chil.nil?

			chil.each do |ch|
				insert_ids ch
			end

		end

	end

end
