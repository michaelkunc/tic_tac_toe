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
    puts "\n"
    puts "Select 1 for #{@game_types[1]}"
    puts "\n"
    puts "Select 2 for Human vs. Computer"
    puts "\n"
    puts "Select 3 for Computer vs. Computer"
    input = gets.chomp
  end



  def play_game
      welcome_message
      game_selection_message
      @players.each {|player| player_names(player)}
      set_tokens
      until game_over
          take_turns
          @round += 1
      end
      game_over_message
  end

  def player_names(player)
    puts "Please enter your name"
    player.name = gets.chomp
    sleep 1
    puts "Welcome #{player.name}"
    sleep 1
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

  def update(player_symbol)
    input = get_valid_input
    if @board.board[input] == "-"
      @board.board[input] = player_symbol
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

end

game = Game.new
game.play_game
