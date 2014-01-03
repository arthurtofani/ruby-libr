Gem::Specification.new do |s|
  s.name        = 'libr'
  s.version     = '0.0.1'
  s.date        = '2014-01-03'
  s.summary     = "Libr"
  s.description = "Digital books framework based on abstract xml definitions"
  s.authors     = ["Arthur Tofani"]
  s.email       = 'gramofone@gmail.com'
  s.files = Dir["{lib,vendor,bin}/**/*"] + Dir["*"]
#  s.files       = [
#	"lib/libr.rb", 
#	"lib/libr/document.rb"
#	]

  s.add_runtime_dependency 'hpricot',  '>= 0.8.6'
  s.add_runtime_dependency 'trollop',  '>= 2.0'

  s.executables << 'libr'
  s.homepage    =
    'http://rubygems.org/gems/libr'
  s.license       = 'GPL-2'
end

