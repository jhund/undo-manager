# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'undo-manager'
  gem.version = '0.0.1'
  gem.platform = Gem::Platform::RUBY

  gem.authors = ['Jo Hund']
  gem.email = 'jhund@clearcove.ca'
  gem.homepage = 'https://github.com/jhund/undo-manager'
  gem.licenses = ['MIT']
  gem.summary = 'undo-manager makes it easy to add undo/redo functionality to a Ruby (on Rails) app.'
  gem.description = %(undo-manager makes it easy to add undo/redo functionality to a Ruby (on Rails) app.)

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_development_dependency 'bundler', ['>= 1.0.0']
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest-spec-expect'
  gem.add_development_dependency 'rake', ['>= 0']
end
