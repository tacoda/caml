module Caml
  class Runner
    def initialize(tasks:, shell:)
      @tasks = tasks
      @shell = shell
    end

    def run(name, args: {}, opts: {})
      plan = Plan.resolve(name, @tasks)
      plan.each do |task|
        bindings = task.name == name ? { args: args, opts: opts } : { args: {}, opts: {} }
        return false unless execute_task(task, **bindings)
      end
      true
    end

    private

    def execute_task(task, args:, opts:)
      return true if task.execute.nil? || Array(task.execute).empty?

      command = build_command(task, args, opts)
      @shell.run(command)
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
