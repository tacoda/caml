module Caml
  class Runner
    class UnknownTask < StandardError
    end

    def initialize(tasks:, shell:)
      @tasks = tasks
      @shell = shell
    end

    def run(name)
      task = find(name)
      @shell.run(task.execute)
    end

    private

    def find(name)
      @tasks.find { |task| task.name == name } ||
        raise(UnknownTask, "no such task: #{name}")
    end
  end
end
