class Recipe < Libr::Environment
	config do
		set_method :html
		set_default_processor CoreProcessor
		set_processor "uri/to/mcq", Mcq	
	end

	before_process do

	end

	after_process do
		generate_index "section[@type='chapter']", :chapter, :root
		generate_index "section[@type='content']", :content, :chapter

		#create_page :template


	end
	

end
