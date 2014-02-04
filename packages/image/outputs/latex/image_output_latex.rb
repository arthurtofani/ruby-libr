class McqOutputLatex < Libr::PackageOutput
	set_name :latex
	set_namespace "image"

	def convert content
		return "\\graphics{...}"
	end
end
