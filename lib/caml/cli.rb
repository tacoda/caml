require 'thor'

module Caml
  class CLI < Thor
    def self.register(config:, runner:)
      config.tasks.each do |task|
        desc task.name, task.desc.to_s
        define_method(task.name) { runner.run(task.name) }
      end
    end
  end
end
