# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'contrail/version'

Gem::Specification.new do |spec|
  spec.name          = "contrail"
  spec.version       = Contrail::VERSION
  spec.authors       = ["Eric Shamow"]
  spec.email         = ["eric.shamow@gmail.com"]
  spec.description   = %q{Simple multi-vendor cloud management}
  spec.summary       = %q{Simple tool for performing basic operations across multiple cloud vendors}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"

  spec.add_dependency "cri", "~> 2.4"
  spec.add_dependency "inifile", "~>2.0"
end
