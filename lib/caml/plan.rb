module Caml
  module Plan
    class Cycle < StandardError
    end

    class UnknownTask < StandardError
    end

    def self.resolve(target_name, tasks)
      index = tasks.to_h { |task| [task.name, task] }
      state = { ordered: [], visiting: [], visited: {} }
      visit(target_name, index, state)
      state[:ordered]
    end

    def self.visit(name, index, state)
      return if state[:visited][name]

      raise_if_cycle(state, name)
      task = index[name] or raise UnknownTask, "no such task: #{name}"

      state[:visiting] << name
      task.needs.each { |dep| visit(dep, index, state) }
      state[:visiting].pop

      state[:visited][name] = true
      state[:ordered] << task
    end
    private_class_method :visit

    def self.raise_if_cycle(state, name)
      return unless state[:visiting].include?(name)

      path = state[:visiting].drop_while { |n| n != name } + [name]
      raise Cycle, "cycle detected: #{path.join(' -> ')}"
    end
    private_class_method :raise_if_cycle
  end
end
