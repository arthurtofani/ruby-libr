class Image < Libr::Package
	set_name "image"
	set_namespace "image"

	def validate content
		binding.pry
		file = "image.dtd"
		dtd = Nokogiri::DTD(File.open(File.join(file)))
		content.validate dtd
		return false ## validate here		
	end
end
