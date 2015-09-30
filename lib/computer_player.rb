class ComputerPlayer < Player
  def generate_computer_name
    computers = %w(Hal WOPR Mother Skynet Jarvis)
    @name = computers.sample
  end

  def computer_evaluate_board(name, token,board)
    return computer_center(name, token, board) if center_empty?(board)
    return computer_corner(name, token, board) if corner_empty?(board)
    computer_random(name, token, board)
  end

  def corner_empty?(board)
    corners = [board.grid[0], board.grid[2], board.grid[6], board.grid[8]]
    corners.any? { |element| element == Board::EMPTY }
  end

  def center_empty?(board)
    board.grid[4] == Board::EMPTY
  end

  def computer_center(name, token, board)
    board.grid[4] = token
    computer_place_token(name, 4, token, board)
  end

  def computer_corner(name, token, board)
    corners = [0, 2, 6, 8]
    cell = (available_spaces(board) & corners).sample
    computer_place_token(name, cell, token, board)
  end

  def computer_random(name, token, board)
    cell = available_spaces(board).sample
    computer_place_token(name, cell, token, board)
  end

  def computer_place_token(name, cell, token, board)
    board.grid[cell] = token
    cell += 1
    Messages.place_token_message(name, cell)
  end

  def available_spaces(board)
    board.grid.each_index.select { |index| board.grid[index] == Board::EMPTY }
  end
end
