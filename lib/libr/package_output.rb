require './package'
module Libr
	class PackageOutput
		@@name = nil
		@@xmlns = nil
		@@packages = {}

		def self.register_package xmlns, pkg
			@@packages[xmlns] = pkg
		end
		
		def self.inherited subcl			
			pkg = @@packages[subcl.get_xmlns]
			if pkg
				pkg.register_output subcl
			end
			#@@packages[xmlns] = pkg
		end

		def self.set_name name
			@@name = name
		end
		def self.set_xmlns xmlns
			@@xmlns = xmlns
		end
		def self.get_name
			@@name
		end
		def self.get_xmlns
			@@xmlns
		end

		def convert content
			return content
		end
	end
end