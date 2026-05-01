class RunnerSpy
  attr_reader :invocations

  def initialize
    @invocations = []
  end

  def run(name)
    @invocations << name
    true
  end
end
