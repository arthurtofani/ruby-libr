require "../lib/libr/document"
require "../lib/libr/package_manager"
require "../lib/libr/package_output"
require "../lib/libr/package"
require 'fileutils'
require 'test/unit'

class TestPackage < Test::Unit::TestCase
	def setup
		@document = Libr::Document.new ".", "./source/"
		@document.load_file "inicial.xml"
		@package_path = File.join(@document.root_path, "packages")
		@xmlns = "mcq"
	end

	def teardown
		@document = nil
	end	

	def create_package_manager
		package_manager = Libr::PackageManager.new(@package_path)
		assert(!package_manager.nil?)
		return package_manager
	end

	def test_check_installed
		package_manager = create_package_manager
		FileUtils.rm_rf File.join(@package_path, "mcq", "install.log")		
		assert_equal(false, package_manager.installed?("mcq"))
		package_manager.create_logfile "mcq"
		assert_equal(true, package_manager.installed?("mcq"))
	end

	def test_load_package
		package_manager = create_package_manager
		package_manager.load_package @xmlns
		binding.pry
		assert_equal 1, package_manager.get_packages.keys.count
		assert_equal 2, package_manager.get_package_outputs(@xmlns).keys.count
	end



end