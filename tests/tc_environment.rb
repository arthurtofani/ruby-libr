require "../lib/libr/document"
require "../lib/libr/package_manager"
require "../lib/libr/package_output"
require "../lib/libr/package"
require "../lib/libr/environment"
require "../lib/libr/assets"
require 'fileutils'
require 'test/unit'

class TestPackage < Test::Unit::TestCase
	def setup
		@document = Libr::Document.new "..", "./source/"
		@document.load_file "inicial.xml"
		@document.read_include_files
		@package_path = File.join(@document.root_path, "packages")
		@xmlns = "image"
		@package_manager = Libr::PackageManager.new(@package_path)
		@package_manager.load_package @xmlns
		@package_manager.load_package_outputs @xmlns		
	end

	def teardown
		@document = nil
	end	

	def test_init
		Libr::Environment.set_environment ".", "./env", @document, "image"
	end

	def test_use_recipe
		test_init
		load './env/html/recipe.rb'
	end

	def test_set_env
		@document.define_environment :html
		env_path = File.join(".", "env", ",image")
		Libr::Environment.set_environment ".", env_path, @document, "image"
		env = Libr::Environment.new ".", env_path, @document, "image"
		assert_equal("image", env.name)		
		env
	end

	def test_set_processor
		env = test_set_env
		env.set_processor "image", :html
		assert_equal(1, env.processors.keys.count)
		assert_equal("html", env.processors["image"])
		env
	end

	def test_process_html
		env = test_set_processor
		env.process!		
	end
end