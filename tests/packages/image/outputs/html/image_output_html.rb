class McqOutputHTML < Libr::PackageOutput
	set_name :html
	set_namespace "image"

	def convert content
		binding.pry
		return content
	end
end
