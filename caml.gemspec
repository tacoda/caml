Gem::Specification.new do |s|
  s.name = 'caml'
  s.version      = '0.1.1'
  s.author       = 'Ian Johnson'
  s.email        = 'tacoda@hey.com'
  s.summary      = 'Build CLI apps using YAML'
  s.homepage     = 'https://github.com/tacoda/caml'
  s.licenses     = ['MIT']
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README.md'))

  s.files         = Dir['{bin,lib,spec}/**/*'] + %w[LICENSE README.md]
  s.executables   = ['caml']

  s.required_ruby_version = '>= 3.0'

  s.add_dependency 'base64', '~> 0.2'
  s.add_dependency 'safe_yaml', '~> 1.0', '>= 1.0.5'
  s.add_dependency 'thor', '~> 1.0', '>= 1.0.1'

  s.metadata['rubygems_mfa_required'] = 'true'
end
