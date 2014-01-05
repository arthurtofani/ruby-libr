class Recipe < Libr::Environment
	
	config do
		set_default_processor CoreProcessor
		set_method :html
		set_processor "uri/to/mcq", Mcq	
	end

	before_process do
			
	end

	after_process do
			
	end

end
