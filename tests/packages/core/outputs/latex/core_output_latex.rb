class CoreOutputLatex < Libr::PackageOutput
	set_name :latex
	set_namespace "core"

	def convert content
		return "\\graphics{...}"
	end
end
