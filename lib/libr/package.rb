require 'nokogiri'
module Libr
	
	# This class should be inherited by others to create new packages with abstract descriptions
	class Package 
		attr_accessor :xmlns, :name, :outputs
		def initialize xmlns
			@xmlns = xmlns
			@name = nil
			@outputs = {}
			PackageOutput.register_package xmlns, self
		end

		# Each package can decide its way to validate some content. XSD or DTD validators can be 
		# used here.
		def validate content
			return true
		end
		
		# PackageOutput calls this method to add external output packages
		def register_output output
			outputs[output.name] = output			
		end

		# Converts the input content using selected output
		def process output_name, content
			if outputs[output_name]
				outputs[output_name].convert content
			else

			end
		end
	end	

end