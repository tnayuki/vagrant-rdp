# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-rdp/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-rdp"
  spec.version       = VagrantPlugins::RDP::VERSION
  spec.authors       = ["Toru Nayuki"]
  spec.email         = ["tnayuki@icloud.com"]
  spec.summary       = %q{With this plugin, you can connect to windows VM by remote desktop connection.}
  spec.description   = %q{With this plugin, you can connect to windows VM by remote desktop connection.}
  spec.homepage      = "https://github.com/tnayuki/vagrant-rdp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
