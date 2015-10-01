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
    puts 'Select 1 for Human vs Human'
    puts 'Select 2 for Human vs Computer'
    puts 'Select 3 for Computer vs Computer'
  end

  def self.computer_vs_computer_game
    puts 'computer vs computer'
  end

  def self.enter_name
    puts 'Please enter your name'
  end

  def self.welcome_name(player_name)
    puts "Welcome #{player_name}"
    pause
  end

  def self.round(round, player_name)
    puts "It's round #{round} and it's #{player_name}'s turn"
  end

  def self.place_token_message(name, index)
    puts "#{name} has placed a token at #{index}"
  end

  def self.computer_player_name(name)
    puts "#{name} is your computer opponent"
  end

  def self.set_tokens(token1, token2)
    puts "Please select your gameplay token...#{token1} or #{token2}"
  end

  def self.try_again
    puts "let's try that again"
    pause
  end

  def self.turn_order
    puts 'Would you like to go first?'
  end

  def self.y_or_n
    puts "Please select 'Y' or 'N'"
  end

  def self.winner(name)
    puts "Congrats! #{name}. You won!!!"
  end

  def self.tie
    puts "It's a tie"
  end

  def self.select
    puts 'Please select your spot'
  end
end
