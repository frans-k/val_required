# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'val_required/version'

Gem::Specification.new do |spec|
  spec.name          = "val_required"
  spec.version       = ValRequired::VERSION
  spec.authors       = ["Frans Krojegård"]
  spec.email         = ["frans@krojegard.com"]
  spec.description   = "expect(''.required!).to raise_error(ValRequired::BlankError)"
  spec.summary       = "A helper method to require values to be set."
  spec.homepage      = "https://github.com/frunns/val_required"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
