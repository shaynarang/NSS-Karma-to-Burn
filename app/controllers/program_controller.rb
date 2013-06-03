class ProgramController
require './lib/program.rb'
  
  def execute
    program = Program.new
    program.run
  end

end