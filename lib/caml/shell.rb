module Caml
  class Shell
    def run(command)
      system(command) ? true : false
    end
  end
end
