module Libr
	class PackageOutput
		@@name = nil
		@@namespace = nil
		
		def self.set_name name
			@@name = name
		end
		def self.set_namespace namespace
			@@namespace = namespace
			Libr::PackageManager.register_output self
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
		def self.inherited subcl		
			#binding.pry	
			#Libr::PackageManager.register_output subcl
		end

		#receives a nokogiri's element and returns another thing
		def convert content
			return content
		end
	end
end