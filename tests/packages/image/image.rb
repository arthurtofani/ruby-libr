class Image < Libr::Package
	set_name "image"
	set_namespace "image"

	def validate content
		
		file = "image.dtd"
		file = File.open(File.join(local_folder, file))
		
		
		dtd = LibXML::XML::Dtd.new(File.read(file))
		doc = LibXML::XML::Document.string(content.to_s, :options => LibXML::XML::Parser::Options::NOWARNING)
		
		a = doc.validate dtd
		return !!a ## validate here		
	end
end
