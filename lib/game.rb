require_relative 'messages'
require_relative 'player'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @tokens = %w(X O)
    @player_1 = Player.new
    @player_2 = Player.new
    @win_conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                       [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @round = 1
    @turn_order = 'normal'
  end

  def start_game
    Messages.welcome
    @board.print_board
    Messages.numbering
    game_selection
  end

  def game_selection
    Messages.game_selection
    input = gets.chomp.to_i
    human_vs_human_game if input == 1
    human_vs_computer_game if input == 2
    Messages.computer_vs_computer_game if input == 3
  end

  def human_vs_human_game
    @player_1.player_name
    @player_2.player_name
    set_tokens
    set_turn_order
    take_turns_with_human until game_over
    game_over_message
  end

  def human_vs_computer_game
    @player_1.player_name
    @player_2.generate_computer_name
    Messages.computer_player_name(@player_2.name)
    set_turn_order
    set_tokens
    take_turns_with_computer until game_over
    game_over_message
  end

  def set_tokens
    Messages.set_tokens(@tokens[0], @tokens[1])
    token = gets.chomp.upcase
    if @tokens.include?(token)
      @player_1.token = token
      @tokens.delete(token)
      @player_2.token = @tokens[0]
    else
      Messages.try_again
      set_tokens
    end
  end

  def set_turn_order
    Messages.turn_order
    Messages.y_or_n
    input = gets.chomp.upcase
    if %w(Y N).include?(input)
      @turn_order = 'normal' unless input == 'N'
    else
      Messages.y_or_n
      set_turn_order
    end
  end

  def turn(name, token)
    @board.print_board
    Messages.round(@round, name)
    update(token)
    check_for_winner(token, name)
    @round += 1
    @board.print_board if game_over
  end

  def take_turns_with_human
    if @turn_order == 'normal' && @round.odd?
      turn(@player_1.name, @player_1.token)
    else
      turn(@player_2.name, @player_2.token)
    end
  end

  def take_turns_with_computer
    if @turn_order == 'normal' && @round.odd?
      turn(@player_1.name, @player_1.token)
    else
      computer_turn(@player_2.name, @player_2.token)
    end
  end

  def computer_turn(name, token)
    @board.print_board
    Messages.round(@round, name)
    computer_evaluate_board(name, token)
    check_for_winner(token, name)
    @round += 1
    @board.print_board if game_over
    Messages.pause
  end

  def computer_evaluate_board(name, token)
    return computer_center(name, token) if center_empty?
    return computer_corner(name, token) if corner_empty?
    computer_random(name, token)
  end

  def corner_empty?
    corners = [@board.grid[0], @board.grid[2], @board.grid[6], @board.grid[8]]
    corners.any? { |element| element == Board::EMPTY }
  end

  def center_empty?
    @board.grid[4] == Board::EMPTY
  end

  def computer_center(name, token)
    @board.grid[4] = token
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
  #         row.each {|element| evaluation_row << @board.grid[element]}
  #         if evaluation_row.count(opponent_token) > 1 && @board.grid[cell] != token
  #           puts "this is inside the token placement loop"
  #           @board.grid[cell] = token
  #           computer_place_token_message(name, cell)
  #         end
  #       end
  #     end
  # end

  def computer_corner(name, token)
    corners = [0, 2, 6, 8]
    cell = (available_spaces & corners).sample
    computer_place_token(name, cell, token)
  end

  def computer_random(name, token)
    cell = available_spaces.sample
    computer_place_token(name, cell, token)
  end

  def computer_place_token(name, cell, token)
    @board.grid[cell] = token
    cell += 1
    Messages.place_token_message(name, cell)
  end

  def available_spaces
    @board.grid.each_index.select { |index| @board.grid[index] == Board::EMPTY }
  end

  def game_over
    @winner || @round > 9
  end

  def game_over_message
    @winner ? Messages.winner(@winner) : Messages.tie
  end

  def check_for_winner(token, name)
    @win_conditions.each do |row|
      @winner = name if row.all? { |cell| @board.grid[cell] == token }
    end
  end

  def select_spot
    Messages.select
    input = gets.chomp.to_i - 1
    return input if (0..8).include?(input) && @board.grid[input] == Board::EMPTY
    Messages.try_again
    select_spot
  end

  def update(token)
    input = select_spot
    @board.grid[input] = token if @board.grid[input] == Board::EMPTY
  end
end
