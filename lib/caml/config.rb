require 'safe_yaml/load'

module Caml
  class Config
    class NotFound < StandardError
    end

    class Malformed < StandardError
    end

    attr_reader :tasks

    def self.load(path)
      raise NotFound, "caml.yaml not found at #{path}" unless File.file?(path)

      raw = parse(File.read(path), path)
      from_raw(raw)
    end

    def self.from_tasks(tasks)
      new(tasks)
    end

    def initialize(tasks)
      @tasks = tasks
    end

    def self.parse(content, path)
      SafeYAML.load(content, safe: true, raise_on_unknown_tag: true) || {}
    rescue Psych::SyntaxError, SafeYAML::UnknownTagError => e
      raise Malformed, "could not parse #{path}: #{e.message}"
    end
    private_class_method :parse

    def self.from_raw(raw)
      tasks = raw.map { |name, body| build_task(name, body || {}) }
      new(tasks)
    end
    private_class_method :from_raw

    def self.build_task(name, body)
      Task.new(
        name: name,
        desc: body['desc'],
        execute: body['execute'],
        args: body['args'] || [],
        opts: body['opts'] || [],
        aliases: body['aliases'] || [],
        needs: body['needs'] || []
      )
    end
    private_class_method :build_task
  end
end
