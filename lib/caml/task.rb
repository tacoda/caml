module Caml
  class Task
    attr_reader :name, :desc, :execute, :args, :opts, :aliases, :needs

    def initialize(name:, desc:, execute:, args: [], opts: [], aliases: [], needs: [])
      @name = name
      @desc = desc
      @execute = execute
      @args = args
      @opts = opts
      @aliases = aliases
      @needs = needs
    end
  end
end
