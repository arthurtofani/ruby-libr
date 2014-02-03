require 'nokogiri'
require 'open-uri'
require 'pry'

module Libr
	class Document
		attr_accessor :doc, :package_manager, :namespaces
		attr_accessor :root_path, :source_path, :assets_path
		
		def initialize root_path=".", source_path="."
			@doc = nil
			@root_path = root_path
			@source_path = source_path
			@package_manager = nil
		end


		def load file
			load_file file
			read_include_files
			read_pkg_namespaces
						
			#load_packages			
		end


		# carrega o arquivo principal do livro
		def load_file file
			fl = File.join(@source_path, file)
			puts "Carregando arquivo #{fl.to_s}"
			@doc = Nokogiri::XML(File.open(fl))
		end




		# carrega os pacotes para a memória: os pacotes do CORE e os específicos da aplicação
		def load_packages
			@package_manager = Libr::PackageManager.new(File.join(@root_path, "packages"))	if @package_manager==nil
			@package_manager.load @namespaces
		end
		
		# baixa e instala pacotes de dependências
		def update_packages
			@package_manager = Libr::PackageManager.new(File.join(@root_path, "packages"))	if @package_manager==nil
			@package_manager.update @namespaces
		end		

		#private		

		def read_include_files			
			@doc.css("include").each do |incl|
				incl_file = incl.attributes["path"].value
				r = Nokogiri::XML(File.open(File.join(@source_path, incl_file)))
				incl.after r.children
				incl.remove
			end			
		end

		def read_pkg_namespaces				
			tmp = []				
			collect_namespaces(tmp, @doc)
			@namespaces = tmp.uniq
		end
		# carrega recursivamente todos os namespaces
		def collect_namespaces arr, el
			nms = el.namespace rescue nil			
			if nms
				arr.push el.namespace.href if !arr.include? el.namespace.href
			end			
			el.elements.each do |elmt|
				collect_namespaces arr, elmt
			end
		end


	end



end

#require './document'
#l = Libr::Document.new
#l.load "unit_1_diagnosticar.xml"
#l.load_include_files
#l.doc.to_xml
