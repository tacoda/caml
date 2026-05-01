require_relative 'lib/caml/version'

Gem::Specification.new do |s|
  s.name        = 'caml'
  s.version     = Caml::VERSION
  s.author      = 'Ian Johnson'
  s.email       = 'tacoda@hey.com'
  s.summary     = 'Build CLI apps from a declarative caml.yaml file'
  s.description = 'caml turns well-documented YAML tasks into a runnable CLI. ' \
                  'Inspired by make and just, but YAML-driven.'
  s.homepage    = 'https://github.com/tacoda/caml'
  s.licenses    = ['MIT']

  s.files       = Dir['{bin,lib}/**/*'] + %w[LICENSE README.md CHANGELOG.md]
  s.executables = ['caml']

  s.metadata['source_code_uri'] = 'https://github.com/tacoda/caml'
  s.metadata['changelog_uri']   = 'https://github.com/tacoda/caml/blob/main/CHANGELOG.md'

  s.required_ruby_version = '>= 3.0'

  s.add_dependency 'base64', '~> 0.2'
  s.add_dependency 'safe_yaml', '~> 1.0', '>= 1.0.5'
  s.add_dependency 'thor', '~> 1.0', '>= 1.0.1'

  s.metadata['rubygems_mfa_required'] = 'true'
end
