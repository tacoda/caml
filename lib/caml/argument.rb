module Caml
  class Argument
    attr_reader :name, :desc, :type

    def initialize(name:, desc:, type: 'string')
      @name = name
      @desc = desc
      @type = type
    end
  end
end
