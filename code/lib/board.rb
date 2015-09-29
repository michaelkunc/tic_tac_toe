class Board
  attr_reader :grid
  EMPTY = '-'

  def initialize
    @grid = Array.new(9, EMPTY)
  end

  def print_board
    puts "\n"
    @grid.each_slice(3) { |row| puts row.join(' | ') }
    puts "\n"
  end
end
