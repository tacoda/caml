class RunnerSpy
  attr_reader :calls

  def initialize
    @calls = []
  end

  def run(name, args: {}, opts: {})
    @calls << { name: name, args: args, opts: opts }
    true
  end

  def invocations
    @calls.map { |call| call[:name] }
  end
end
