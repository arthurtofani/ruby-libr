require 'nokogiri'
require 'libxml'
module Libr

	# This class should be inherited by others to create new packages with abstract descriptions
	class Package 
		@@namespace
		def self.inherited subcl			
			#binding.pry

		end

		def self.register name, namespace
			@@namespace = namespace
			Libr::PackageManager.register_package self, name, namespace
		end
		
		def local_folder
			a = self.class.instance_methods(false).map { |m| 
			  self.class.instance_method(m).source_location.first
			}.uniq.first	
			return File.dirname(a)
		end

		

		# Each package can decide its way to validate some content. XSD or DTD validators can be 
		# used here.
		def validate content
			return true
		end
		

		# Converts the input content using selected output
		def process output_name, content
			output = Libr::PackageManager.get_output @@namespace, output_name
			output.convert content
		end
	end	

end
