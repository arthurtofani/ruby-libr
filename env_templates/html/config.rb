module Config
	include 'libr/recipe'

	set_default_processor CoreProcessor
	set_method :html
	set_processor "uri/to/mcq", Mcq

end


