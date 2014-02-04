require 'nokogiri'
require 'libxml'
module Libr

	# This class should be inherited by others to create new packages with abstract descriptions
	class Package 
		@@name = nil
		@@namespace = nil

		def self.inherited subcl			
			#binding.pry

		end

		def self.set_name name			
			@@name = name
		end
		def self.set_namespace namespace
			return if !@@namespace.nil?			
			@@namespace = namespace
			Libr::PackageManager.register_package self
		end
		def self.get_name
			@@name
		end
		def self.get_namespace
			@@namespace
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
