lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zenlish/version"

# Implementation module
module PkgExtending
  def self.pkg_files(aPackage)
    file_list = Dir[
      '.rubocop.yml',
      '.rspec',
      '.yardopts',
      'appveyor.yml',
      'cucumber.yml',
      'Gemfile',
      'Rakefile',
      'CHANGELOG.md',
      'LICENSE.txt',
      'README.md',
      'zenlish.gemspec',
      'bin/*.rb',
      'lib/*.*',
      'lib/**/*.rb',
      'spec/**/*.rb'
    ]
    aPackage.files = file_list
    aPackage.test_files = Dir['spec/**/*_spec.rb']
    aPackage.require_path = 'lib'
  end

  def self.pkg_documentation(aPackage)
    aPackage.rdoc_options << '--charset=UTF-8 --exclude="examples|spec"'
    aPackage.extra_rdoc_files = ['README.md']
  end
end # module


Gem::Specification.new do |spec|
  spec.name          = 'zenlish'
  spec.version       = Zenlish::VERSION
  spec.authors       = ['Dimitri Geshef']
  spec.email         = ['famished.tiger@yahoo.com']

  spec.summary       = %q{A toolkit for the Zenlish language (a simplified English language).}
  spec.description   = %q{A toolkit for the Zenlish language (a simplified English language).}
  spec.homepage      = "https://github.com/famished-tiger/zenlish."
  spec.license       = 'MIT'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  PkgExtending.pkg_files(spec)
  PkgExtending.pkg_documentation(spec)
  
  # Runtime dependencies
  spec.add_dependency 'rley', '~> 0.7'  

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
