module Caml
  module Init
    class Conflict < StandardError
    end

    TEMPLATE = <<~YAML.freeze
      hello:
        desc: A starter task — replace me
        execute: echo Hello, caml!
    YAML

    def self.scaffold(path)
      raise Conflict, "#{path} already exists" if File.exist?(path)

      File.write(path, TEMPLATE)
    end
  end
end
