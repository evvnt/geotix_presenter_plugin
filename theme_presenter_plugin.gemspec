
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'theme_presenter_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "theme_presenter_plugin"
  spec.version       = ThemePresentersPlugin::Version::VERSION
  spec.authors       = ["Evvnt"]
  spec.email         = ["dev@evvnt.com"]

  spec.summary       = "A plugin to add Evvnt brand theme to presenters"
  spec.homepage      = 'http://github.com/evvnt/theme_presenters_plugin'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.19"
  spec.add_development_dependency "rake", "~> 12.3"
end
