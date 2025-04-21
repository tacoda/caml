require 'safe_yaml/load'

module Caml
  # def self.wrap(object)
  #   if object.nil?
  #     []
  #   elsif object.respond_to?(:to_ary)
  #     object.to_ary || [object]
  #   else
  #     [object]
  #   end
  # end

  class Config
    def initialize
      # Recursively load (prompt to init if it doesn't exist)
      SafeYAML::OPTIONS[:default_mode] = :safe
      @config = YAML.load_file(File.join(Dir.getwd, 'caml.yaml'))
    end

    def directives
      @config
    end

    def to_s
      inspect
    end
  end

  class Command
    attr_reader :name, :desc, :aliases, :args, :opts, :execute

    def initialize(options = {})
      @name = options['name']
      @desc = options['desc']
      @aliases = options['aliases']
      @args = options['args']
      @opts = options['opts']
      @execute = options['execute']
    end

    def dispatcher
      if opts.empty?
        executor
      else
        first_clause = "if options[:#{opts.first.name.to_sym}]\nexecute { \"#{opts.first.execute}\" }\n"
        # else_clause = directive.execute.nil? ? "#\n" : "else\nexecute { \"#{wrap(directive.execute).join(';')}\" }\nend"
        # clauses = directive.options.drop(1).map { |option| "elsif options[:#{option.name.to_sym}]\nexecute { \"#{wrap(option.execute).join(';')}\" }\n" }.join
        # dispatcher = first_clause + clauses + else_clause
        puts first_clause
        executor
      end
    end

    def executor
      if execute.respond_to?(:join)
<<-EOS
execute do
<<-COMMANDS
#{execute.join("\n")}
COMMANDS
end
EOS
      else
        "execute { \"#{execute}\" }\n"
      end
    end

    def to_s
      descriptor = "desc '#{name}', '#{desc}'\n"
      options = opts.empty? ? '' : opts.join("\n") + "\n"
      signature = "def #{name}\n" # TODO: args
      close_scope = "end\n"
      descriptor + options + signature + executor + close_scope
    end
  end

  class Option
    attr_reader :name, :type, :desc, :aliases, :execute

    def initialize(options = {})
      @name = options['name']
      @type = options['type']
      @desc = options['desc']
      @aliases = options['aliases']
      @execute = options['execute']
    end

    def to_s
      "option :#{name}, type: :#{type}, desc: '#{desc}'"
    end
  end

  class Argument
    attr_reader :name, :type, :desc, :value

    def initialize(options ={})
      @name = options['name']
      @desc = options['desc']
      @type = options['type']
    end

    def to_s
        inspect
    end
  end
end
