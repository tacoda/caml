module Caml
  class Option
    attr_reader :name, :desc, :type, :aliases, :default, :execute

    def initialize(name:, desc:, type: 'boolean', aliases: [], default: nil, execute: nil)
      @name = name
      @desc = desc
      @type = type
      @aliases = aliases
      @default = default
      @execute = execute
    end
  end
end
