class Player
  attr_accessor :name, :token

  def initialize
    @name = nil
    @token = nil
  end

  def generate_computer_name
    computers = %w(Hal WOPR Mother Skynet Jarvis)
    @name = computers.sample
  end

  def player_name
    Messages.enter_name
    @name = gets.chomp
    Messages.pause
    Messages.welcome_name(@name)
  end
end
