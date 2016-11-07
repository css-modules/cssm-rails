# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cssm-rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'cssm-rails'
  spec.version       = CSSMRails::VERSION
  spec.authors       = ['Tomas Celizna']
  spec.email         = ['mail@tomascelizna.com']

  spec.summary       = 'CSS Modules for Rails'
  spec.description   = 'A CSS Module is a CSS file in which class names and animation names are scoped locally.'
  spec.homepage      = 'https://github.com/css-modules/cssm-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails'
  spec.add_dependency 'sass'
  spec.add_dependency 'sprockets'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-rails'
  spec.add_development_dependency 'minitest-rails-capybara'
  spec.add_development_dependency 'rake', '~> 10.0'
end
