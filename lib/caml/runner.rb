module Caml
  class Runner
    class UnknownTask < StandardError
    end

    def initialize(tasks:, shell:)
      @tasks = tasks
      @shell = shell
    end

    def run(name, args: {}, opts: {})
      task = find(name)
      command = build_command(task, args, opts)
      @shell.run(command)
    end

    private

    def find(name)
      @tasks.find { |task| task.name == name } ||
        raise(UnknownTask, "no such task: #{name}")
    end

    def build_command(task, args, opts)
      execute = effective_execute(task, opts)
      bindings = args.merge(opts)
      Array(execute).map { |step| Interpolation.apply(step, bindings) }.join(' && ')
    end

    def effective_execute(task, opts)
      override = task.opts.find { |opt| opt.execute && opts[opt.name] }
      override ? override.execute : task.execute
    end
  end
end
