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
    puts 'Please enter your name'
    @name = gets.chomp
    sleep 1
    puts "Welcome #{@name}"
    sleep 1
  end
end
