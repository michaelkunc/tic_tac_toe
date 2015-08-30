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
    set_tokens
    until game_over
      turn(@player_1.name, @player_1.token)
      @round += 1
      computer_turn(@player_2.name, @player_2.token, @player_1.token)
      @round += 1
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
    if @round.odd?
      turn(@player_1.name, @player_1.token)
    else
      turn(@player_2.name, @player_2.token)
    end
  end


  def computer_turn(name, token, opponent_token)
    @board.print_board
    round_message(name)
    computer_evaluate_board(name,token, opponent_token)
    sleep 1
  end

  def computer_evaluate_board(name, token, opponent_token)
    if @board.board[4] == "-"
      computer_center(name, token)
    elsif @board.board.count(opponent_token) > 1
      computer_protect(name, token, opponent_token)
    else
      computer_random(name, token)
    end
  end

  def computer_center(name, token)
      @board.board[4] = token
      computer_place_token_message(name, 4)
  end

  def computer_protect(name, token, opponent_token)
    #this iteration is happening correctly
      @win_conditions.each do |row|
        #this condition is not being evaluated properly this is returning zero
        puts row.count(opponent_token)
        if row.count(opponent_token) > 1
          cell = row.index("-")
          @board.board[cell] = token
          commputer_place_token_message(name,cell )
        else
          puts "If logic seems to be broken"
        end
      end

  end

  def computer_random(name, token)
    available_spaces = []
    @board.board.each_with_index {|cell, index| available_spaces << index if cell == "-"}
    cell = available_spaces.sample
    @board.board[cell] = token
    #this message needs to be elsewhere
    computer_place_token_message(name, cell)
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
    if (0..8).include?(input) && @board.board[input] == "-"
      input
    else
      puts 'that selection is not valid'
      sleep 1
      get_valid_input
    end
  end

  def update(token)
    input = get_valid_input
    if @board.board[input] == "-"
      @board.board[input] = token
    end
  end



  # def eval_board
  #   spot = nil
  #   until spot
  #     if @board[4] == "4"
  #       spot = 4
  #       @board[spot] = @computer_token
  #     else
  #       spot = get_best_move(@board, @computer_token)
  #       if @board[spot] != "X" && @board[spot] != "O"
  #         @board[spot] = @computer_token
  #       else
  #         spot = nil
  #       end
  #     end
  #   end
  # end

  # def get_best_move(board, next_player, depth = 0, best_score = {})
  #   available_spaces = []
  #   best_move = nil
  #   board.each do |s|
  #     if s != "X" && s != "O"
  #       available_spaces << s
  #     end
  #   end
  #   available_spaces.each do |as|
  #     board[as.to_i] = @computer_token
  #     if game_is_over(board)
  #       best_move = as.to_i
  #       board[as.to_i] = as
  #       return best_move
  #     else
  #       board[as.to_i] = @human_token
  #       if game_is_over(board)
  #         best_move = as.to_i
  #         board[as.to_i] = as
  #         return best_move
  #       else
  #         board[as.to_i] = as
  #       end
  #     end
  #   end
  #   if best_move
  #     return best_move
  #   else
  #     n = rand(0..available_spaces.count)
  #     return available_spaces[n].to_i
  #   end
  # end


end


class Board
  attr_reader :board

  def initialize
    @board = Array.new(9, "-")
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

# game = Game.new
# game.start_game
