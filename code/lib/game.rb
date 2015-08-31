class Game
  def initialize
    @board = Board.new
    @tokens = ['X', 'O']
    @player_1 = Player.new
    @player_2 = Player.new
    @players = [@player_1, @player_2]
    @win_conditions = [[0, 1 ,2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                       [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @winner = nil
    @round = 1
    @turn_order = 'normal'
    @game_types = {1 => "Human vs. Human", 2 => "Human vs. Computer", 3 => "Computer vs Computer"}
    @this_game_type = nil
  end

  def start_game
    welcome_message
    game_selection_message
    game_selection
  end

  def welcome_message
    puts "Welcome to my Tic Tac Toe game"
    sleep 1
    puts "-------------------------------"
    @board.print_board
    puts "The board is numbered 1 - 9 starting with the top left"
    sleep 1
  end

  def game_selection_message
    puts "Please select the type of game your would like to play"
    @game_types.each do |key, value|
      puts "Select #{key} for #{value}"
    end
    input = gets.chomp.to_i
    @this_game_type = @game_types[input]
  end

#not crazy about this design right now
  def game_selection
    case @this_game_type
    when @game_types[1]
      human_vs_human_game
    when @game_types[2]
      human_vs_computer_game
    when @game_types[3]
      computer_vs_computer_game
    end
  end


  def human_vs_human_game
      @player_1.player_name
      @player_2.player_name
      set_tokens
      get_turn_order
      until game_over
          take_turns
          @round += 1
      end
      game_over_message
  end

  def human_vs_computer_game
    @player_1.player_name
    @player_2.generate_computer_name
    puts "#{@player_2.name} is your computer opponent"
    get_turn_order
    set_tokens
    until game_over
      if @turn_order == 'normal'
        turn(@player_1.name, @player_1.token)
        @round += 1
        computer_turn(@player_2.name, @player_2.token, @player_1.token)
        @round += 1
      else
        computer_turn(@player_2.name, @player_2.token, @player_1.token)
        @round += 1
        turn(@player_1.name, @player_1.token)
        @round += 1
      end

    end
      game_over_message
  end

  def computer_vs_computer_game
    puts "computer vs computer"
  end


  def set_tokens
    puts "Please select your gameplay token...#{@tokens[0]} or #{@tokens[1]}"
    token = gets.chomp.upcase
    if @tokens.include?(token)
      @player_1.token = token
      @tokens.delete(token)
      @player_2.token = @tokens[0]
    else
      puts "Let's try that again"
      sleep 2
      set_tokens
    end
  end

  def get_turn_order
    puts "Would you like to go first? Select 'Y' or 'N' "
    input = gets.chomp.upcase
    if (['Y', 'N']).include?(input)
      if input == 'N'
        @turn_order = 'reverse'
      end
    else
      puts 'Please select Y or N'
      get turn_order
    end

  end

  def round_message(player_name)
    puts "It's round #{@round} and it's #{player_name}'s turn"
  end

  def turn(name,token)
    @board.print_board
    round_message(name)
    update(token)
    check_for_winner(token, name)
    @board.print_board if game_over
  end

  def take_turns
    if @turn_order == 'normal'
      if @round.odd?
        turn(@player_1.name, @player_1.token)
      else
        turn(@player_2.name, @player_2.token)
      end
    else
      if @round.odd?
        turn(@player_2.name, @player_2.token)
      else
        turn(@player_1.name, @player_1.token)
      end
    end
  end


  def computer_turn(name, token, opponent_token)
    @board.print_board
    round_message(name)
    computer_evaluate_board(name, token, opponent_token)
    check_for_winner(token, name)
    @board.print_board if game_over
    sleep 1
  end

  def computer_evaluate_board(name, token, opponent_token)
    if @board.board[4] == @board.empty_space
      computer_center(name, token)
    elsif @board.board[0] == @board.empty_space || @board.board[2] == @board.empty_space || @board.board[6] == @board.empty_space || @board.board[8] == @board.empty_space
      computer_corner(name, token)
    else
      computer_random(name, token)
    end
  end

  def computer_center(name, token)
      @board.board[4] = token
      computer_place_token_message(name, 4)
  end

  # def computer_protect(name, token, opponent_token)
  #     @win_conditions.each do |row|
  #       puts "this is the outer win conditions loop"
  #       available_spaces
  #       evaluation_row = []
  #       cell = row & available_spaces
  #       if cell.length > 0
  #         puts "this is inside the cell length > 1 loop"
  #         cell = cell[0]
  #         row.each {|element| evaluation_row << @board.board[element]}
  #         if evaluation_row.count(opponent_token) > 1 && @board.board[cell] != token
  #           puts "this is inside the token placement loop"
  #           @board.board[cell] = token
  #           computer_place_token_message(name, cell)
  #         end
  #       end
  #     end
  # end

  def computer_corner(name, token)
    available_spaces
    corners = [0,2,6,8]
    possible_cells = available_spaces & corners
    cell = possible_cells[0]
    if cell
      @board.board[cell] = token
      computer_place_token_message(name, cell)
    end
  end


  def computer_random(name, token)
    available_spaces
    cell = available_spaces.sample
    if cell
      @board.board[cell] = token
      computer_place_token_message(name, cell)
    end
  end


  def available_spaces
    available_spaces = []
    @board.board.each_with_index {|cell, index| available_spaces << index if cell == @board.empty_space}
    available_spaces
  end



  def computer_place_token_message(name, index)
    index += 1
    puts "#{name} has placed a token at #{index}"
  end


  def game_over
     @winner || @round > 9
  end

  def game_over_message
    if @winner
      puts "Congrats! #{@winner}. You Won!!!"
    else
      puts "It's a tie"
    end
  end

  def check_for_winner(token, name)
    @win_conditions.each do |row|
      if row.all? {|cell| @board.board[cell] == token}
        @winner = name
      end
    end
  end


  def get_valid_input
    puts "Please select your spot"
    input = gets.chomp.to_i - 1
    if (0..8).include?(input) && @board.board[input] == @board.empty_space
      input
    else
      puts 'that selection is not valid'
      sleep 1
      get_valid_input
    end
  end

  def update(token)
    input = get_valid_input
    if @board.board[input] == @board.empty_space
      @board.board[input] = token
    end
  end

end


class Board
  attr_reader :board, :empty_space

  def initialize
    @empty_space = "-"
    @board = Array.new(9, @empty_space)
  end

  def print_board
    puts "\n"
    @board.each_slice(3) {|row| puts row.join(" | ")}
    puts "\n"
  end

end

class Player
  attr_accessor :name, :token

  def initialize
    @name = nil
    @token = nil
  end

  def generate_computer_name
    computers = ['Hal', 'WOPR', 'Mother', 'Skynet', 'Jarvis']
    @name = computers.sample
  end

  def player_name
    puts "Please enter your name"
    @name = gets.chomp
    sleep 1
    puts "Welcome #{@name}"
    sleep 1
  end


end

game = Game.new
game.start_game
