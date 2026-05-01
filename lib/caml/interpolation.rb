require 'shellwords'

module Caml
  module Interpolation
    class Missing < StandardError
    end

    TOKEN = /\{\{(\w+)\}\}/

    def self.apply(template, values)
      template.gsub(TOKEN) do
        name = Regexp.last_match(1)
        raise Missing, "no value for {{#{name}}}" unless values.key?(name)

        Shellwords.escape(values[name].to_s)
      end
    end
  end
end
