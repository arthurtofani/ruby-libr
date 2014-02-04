require "../lib/libr/document"
require "../lib/libr/package_manager"
require "../lib/libr/package"
require "../lib/libr/package_output"

require 'test/unit'

class TestPackage < Test::Unit::TestCase
	def setup
		
	end
	def teardown

	end	

	def test_load_file
		document = Libr::Document.new ".", "./source/"
		document.load_file "inicial.xml"
		assert !document.doc.nil?
		document
	end

	def test_read_include_files
		# check before
		document = test_load_file
		assert_equal(1, document.doc.css("include").count)
		
		# check after
		document.read_include_files
		assert_equal(0, document.doc.css("include").count)
		assert_equal(1, document.doc.css("#pg_14").count)	
		document
	end

	def test_read_pkg_namespaces		
		document = test_read_include_files
		document.read_pkg_namespaces
		assert_equal(2, document.namespaces.count)
		document
	end

	def test_load_environments
		document = test_read_pkg_namespaces
		document.load_environments
		assert_equal(2, document.environments.count)
		document
	end

	def test_validation
		document = Libr::Document.new ".", "./source/"
		document.load "inicial.xml"

		document.validate_doc
		#assert_equal(2, document.environments.count)
	end


end