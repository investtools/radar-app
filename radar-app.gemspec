# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'radar/app/version'

Gem::Specification.new do |spec|
  spec.name          = "radar-app"
  spec.version       = Radar::App::VERSION
  spec.authors       = ["Leonardo Mendonca"]
  spec.email         = ["leonardo.mendonca@investtools.com.br"]
  spec.summary       = %q{radar-app generator}
  spec.description   = %q{generates and run a radar-app.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "thor", "~> 0.19"
end
