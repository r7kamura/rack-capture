require_relative 'lib/rack/capture/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-capture'
  spec.version       = Rack::Capture::VERSION
  spec.authors       = ['Ryo Nakamura']
  spec.email         = ['r7kamura@gmail.com']

  spec.summary       = 'Generate static files from Rack application and URLs.'
  spec.homepage      = 'https://github.com/r7kamura/rack-capture'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'rack'
end
