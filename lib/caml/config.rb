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
        args: build_args(body['args']),
        opts: build_opts(body['opts']),
        aliases: body['aliases'] || [],
        needs: body['needs'] || []
      )
    end
    private_class_method :build_task

    def self.build_args(raw)
      return [] unless raw

      raw.map { |name, fields| build_argument(name, fields || {}) }
    end
    private_class_method :build_args

    def self.build_argument(name, fields)
      attrs = { name: name, desc: fields['desc'] }
      attrs[:type] = fields['type'] if fields['type']
      Argument.new(**attrs)
    end
    private_class_method :build_argument

    def self.build_opts(raw)
      return [] unless raw

      raw.map { |name, fields| build_option(name, fields || {}) }
    end
    private_class_method :build_opts

    def self.build_option(name, fields)
      attrs = { name: name, desc: fields['desc'] }
      attrs[:type] = fields['type'] if fields['type']
      attrs[:aliases] = fields['aliases'] if fields['aliases']
      attrs[:default] = fields['default'] unless fields['default'].nil?
      attrs[:execute] = fields['execute'] if fields['execute']
      Option.new(**attrs)
    end
    private_class_method :build_option
  end
end
