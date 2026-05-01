class FakeShell
  attr_reader :commands

  def initialize
    @commands = []
    @results = [true]
  end

  def next_result=(value)
    @results = [value]
  end

  def next_results=(values)
    @results = values.dup
  end

  def run(command)
    @commands << command
    @results.length > 1 ? @results.shift : @results.first
  end
end
