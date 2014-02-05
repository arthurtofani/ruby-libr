class CoreOutputHTML < Libr::PackageOutput
	set_name :html
	set_namespace "core"

	def convert content
		binding.pry
		new_file = content.attributes["file"].value
		credits =  content.xpath("//a:credits", {"a"=> "image"}).map{|x| x.inner_html.strip} rescue []
		description =  content.xpath("//a:description", {"a"=> "image"}).first.inner_html.strip.gsub("\"", "'") rescue nil
		res =  "<img src=\"#{new_file}\" alt=\"#{description}\" />"
		change_content content, res
	end

# tornar mais genérico
	def change_content source_content, dest_content
		d = dest_content.to_s
		source_content.after Nokogiri(d).children
		source_content.remove
	end	

end
