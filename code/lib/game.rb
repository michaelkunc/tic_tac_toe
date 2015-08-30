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
  end

  def welcome_message
    puts "Welcome to my Tic Tac Toe game"
    sleep 1
    puts "-------------------------------"
    @board.print_board
    puts "The board is numbered 1 - 9 starting with the top left"
    sleep 1
  end


  def start_game
      welcome_message
      @players.each {|player| player_names(player)}
      set_tokens
      until game_over
        @players.each do |player|
          @board.print_board
          round_message(player.name)
          update(player.token)
          check_for_winner(player)
        end
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


#watch this interface
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

  def game_over
    @winner != nil || @round > 9
  end

  def game_over_message
    if @winner
      puts "Congrats! #{@winner}. You Won!!!"
    else
      puts "It's a tie"
    end
  end

#watch this interface
  def check_for_winner(player)
    @win_conditions.each do |row|
      if row.all? {|cell| @board.board[cell] == player.token}
        @winner = player.name
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

  # def game_is_over(board)

  #   [board[0], board[1], board[2]].uniq.length == 1 ||
  #   [board[3], board[4], board[5]].uniq.length == 1 ||
  #   [board[6], board[7], board[8]].uniq.length == 1 ||
  #   [board[0], board[3], board[6]].uniq.length == 1 ||
  #   [board[1], board[4], board[7]].uniq.length == 1 ||
  #   [board[2], board[5], board[8]].uniq.length == 1 ||
  #   [board[0], board[4], board[8]].uniq.length == 1 ||
  #   [board[2], board[4], board[6]].uniq.length == 1
  # end

  # def tie(board)
  #   board.all? { |cell| cell == "X" || cell == "O" }
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
game.start_game
