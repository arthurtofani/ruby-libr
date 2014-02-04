module Libr
	class PackageOutput
		@@name = nil
		@@namespace = nil
		
		def self.set_name name
			@@name = name
		end
		def self.set_namespace namespace
			@@namespace = namespace
		end
		def self.get_name
			@@name
		end
		def self.get_namespace
			@@namespace
		end

		def self.inherited subcl			
			Libr::PackageManager.register_output subcl
		end

		#receives a nokogiri's element and returns another thing
		def convert content
			return content
		end
	end
end