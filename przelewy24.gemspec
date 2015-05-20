# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'przelewy24/version'

Gem::Specification.new do |spec|
  spec.name          = "przelewy24"
  spec.version       = Przelewy24::VERSION
  spec.authors       = ["Michał Młoźniak"]
  spec.email         = ["m.mlozniak@gmail.com"]

  spec.summary       = %q{Integration with Przelewy24 payment gateway.}
  spec.description   = %q{Integration with Przelewy24 payment gateway.}
  spec.homepage      = "https://github.com/visualitypl/przelewy24"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
