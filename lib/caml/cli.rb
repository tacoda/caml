require 'thor'

module Caml
  class CLI < Thor
    THOR_TYPES = {
      'string' => :string,
      'boolean' => :boolean,
      'numeric' => :numeric
    }.freeze

    def self.exit_on_failure?
      true
    end

    desc 'init', 'Scaffold a starter caml.yaml in the current directory'
    def init
      target = File.join(Dir.pwd, 'caml.yaml')
      Init.scaffold(target)
      say "Created #{target}", :green
    rescue Init::Conflict => e
      say "caml init: #{e.message}", :red
      exit 1
    end

    def self.register(config:, runner:)
      config.tasks.each { |task| register_task(task, runner) }
    end

    def self.register_task(task, runner)
      task.opts.each { |opt| register_option(opt) }
      desc usage(task), task.desc.to_s
      task.aliases.each { |alias_name| map alias_name => task.name.to_sym }
      define_dispatcher(task, runner)
    end

    def self.define_dispatcher(task, runner)
      define_method(task.name) do |*positional|
        args_hash = task.args.each_with_index.to_h { |arg, i| [arg.name, positional[i]] }
        runner.run(task.name, args: args_hash, opts: options.to_h)
      end
    end

    def self.register_option(opt)
      attrs = {
        type: thor_type(opt.type),
        desc: opt.desc.to_s,
        aliases: opt.aliases.map { |a| "-#{a}" }
      }
      attrs[:default] = opt.default unless opt.default.nil?
      method_option opt.name, **attrs
    end

    def self.thor_type(yaml_type)
      THOR_TYPES.fetch(yaml_type, :string)
    end

    def self.usage(task)
      positional = task.args.map { |arg| arg.name.upcase }.join(' ')
      positional.empty? ? task.name : "#{task.name} #{positional}"
    end
  end
end
