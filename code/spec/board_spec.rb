require_relative 'game'

describe 'Board' do
  board = Board.new

  it 'returns a board object' do
    expect(board).to be_an_instance_of Board
  end

  it 'should have a length of 9' do
    expect(board.board.length).to eq(9)
  end

  it 'should contain only "-" ' do
    expect(board.board.all? { |e| e == '-' }).to eq(true)
  end
end

describe 'Player' do
  player = Player.new

  it 'returns a Player object' do
    expect(player).to be_an_instance_of Player
  end
end
