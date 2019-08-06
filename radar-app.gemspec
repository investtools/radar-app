# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'radar/app/version'

Gem::Specification.new do |spec|
  spec.name          = "radar-app"
  spec.version       = Radar::App::VERSION
  spec.authors       = ["Leonardo Mendonca", "André Aizim Kelmanson"]
  spec.email         = ["desenvolvimento@investtools.com.br"]
  spec.summary       = %q{radar-app generator}
  spec.description   = %q{generates and run a radar-app.}
  spec.homepage      = "http://www.investtools.com.br/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "guard-rake"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "radar-api", ">= 0.10.0"
  spec.add_dependency "thin", "1.6.2"
  spec.add_dependency "connection_pool", "~> 2.0"
  spec.add_dependency "activesupport", "~> 4.1"
  spec.add_dependency "RaymondChou-thrift_client", "~> 0.9"
  spec.add_dependency "sigdump", "~> 0.2.4"
end
