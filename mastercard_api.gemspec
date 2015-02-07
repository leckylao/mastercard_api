# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mastercard_api/version'

Gem::Specification.new do |spec|
  spec.name          = "mastercard_api"
  spec.version       = MastercardApi::VERSION
  spec.authors       = ["Brady Georgen"]
  spec.email         = ["pbradygeorgen@me.com"]
  spec.description   = %q{The Common OpenAuth Connector classes for the Mastercard API}
  spec.summary       = %q{The Common OpenAuth Connector classes for the Mastercard API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['LICENSE.txt', 'README.md', 'lib/**/*', 'data/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
