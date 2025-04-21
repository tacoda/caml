Gem::Specification.new do |s| 
    s.name         = "caml"
    s.version      = "0.1.1"
    s.author       = "Ian Johnson"
    s.email        = "tacoda@hey.com"
    s.summary      = "Build CLI apps using YAML"
    s.homepage     = "https://github.com/tacoda/caml"
    s.licenses     = ['MIT']
    s.description  = File.read(File.join(File.dirname(__FILE__), 'README.md'))
    
    s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README.md)
    s.test_files    = Dir["spec/**/*"]
    s.executables   = [ 'caml' ]
    
    s.required_ruby_version = '>=1.9'
    s.add_development_dependency 'rspec'
  end
