class Mcq < Libr::Package
	set_name "mcq"
	set_namespace "http://tofani.com.br/libr/packages/mcq"

	def validate content
		return true ## validate here		
	end
end



class McqOutputHTML < Libr::PackageOutput
	set_name "html"
	set_namespace "http://tofani.com.br/libr/packages/mcq"

	def convert content
		return content
	end
end

class McqOutputLatex < Libr::PackageOutput
	set_name "latex"
	set_namespace "http://tofani.com.br/libr/packages/mcq"

	def convert content
		return content
	end
end
