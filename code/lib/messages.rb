class Messages
  def self.welcome
    puts 'Welcome to my Tic Tac Toe Game'
    pause
    puts '___________________________'
  end

  def self.numbering
    puts 'The board is numbered 1 - 9 starting with the top left'
    pause
  end

  def self.pause
    sleep 1
  end

  def self.game_selection
    puts 'Please select the type of game your would like to play'
  end

  def self.game_types(key, value)
    puts "Select #{key} for #{value}"
  end

  def self.computer_vs_computer_game
    puts 'computer vs computer'
  end

  def self.round_message(round, player_name)
    puts "It's round #{round} and it's #{player_name}'s turn"
  end

  def self.place_token_message(name, index)
    puts "#{name} has placed a token at #{index}"
  end
end
