class FakeShell
  attr_reader :commands
  attr_writer :next_result

  def initialize
    @commands = []
    @next_result = true
  end

  def run(command)
    @commands << command
    @next_result
  end
end
