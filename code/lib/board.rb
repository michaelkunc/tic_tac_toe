class Board
  attr_reader :grid
  EMPTY_SPACE = '-'

  def initialize
    @grid = Array.new(9, EMPTY_SPACE)
  end

  def print_board
    puts "\n"
    @grid.each_slice(3) { |row| puts row.join(' | ') }
    puts "\n"
  end
end
