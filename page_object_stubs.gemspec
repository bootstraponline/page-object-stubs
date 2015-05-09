require_relative 'lib/page_object_stubs/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 1.9.3'

  spec.name    = 'page_object_stubs'
  spec.version = PageObjectStubs::VERSION
  spec.date    = PageObjectStubs::DATE
  spec.license = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  spec.authors = spec.email = ['code@bootstraponline.com']

  spec.summary     = spec.description = 'PageObject stub generator for RubyMine'
  spec.description += '.' # avoid identical warning
  spec.homepage    = 'https://github.com/bootstraponline/page_object_stubs'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'parser', '~> 2.2.2.2'

  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'appium_thor', '~> 0.0.7'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
end
