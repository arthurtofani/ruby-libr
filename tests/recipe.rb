Libr::Environment.start do |env|

	## como associar recursos externos. no caso, um gerador de glossário
	glossary = Libr::Glossary.new "glossfile.xml"
	glossary.config do |cfg|
		cfg.tag_frequency = Libr::Glossary::FIRST_OCCURRENCE_PER_FILE
		cfg.word_mask = "<span class='glossary-word'>$WORD$</span>"
	end

	## definir sob quais ambientes os pacotes serão processados.
	env.set_processor "xmlns1", :html
	env.set_processor "xmlns2", :html
	env.set_processor "xmlns3", :simple_html

	## define as saídas
	env.assets.set_type_output :images, "/img"

	
	# produz o objeto output
	env.process!


	# modela o DOM da saída. divide em páginas
	env.output.css(".page").each do |page|
		env.create_file page, {template: "content.html.erb", name: page.attributes["id"] + ".html", files: "pages"}
	end
	env.output.css(".chapter-start").each do |page|
		env.create_file page, {template: "chapter_start.html.erb", name: page.attributes["id"] + ".html", files: "pages"}
	end	

	
	env.file_content(".page") do |page|
		glossary.process page do |proc|
			proc.word_mask = "<span class='glossary-word'>$WORD$</span>"
		end
	end

	env.file_content("#pg_15") do |page|
		img = assets.get("imagem1.jpg")
		page.css("#test").append "<img src='#{img.output_path}' />"
		env.add_resource_file :javascript "/home/test/javascript.js"
	end


	# criar sumários
	# criar índices
	# cria spine
	# sei la

	
end