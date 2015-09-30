require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/messages'

describe 'Game' do
  game = Game.new

  it 'returns a game object' do
    expect(game).to be_an_instance_of Game
  end

  it 'should have a Board object' do
    expect(game.instance_variable_get(:@board)).to be_an_instance_of Board
  end

  it 'should have X & O as tokens' do
    expect(game.instance_variable_get(:@tokens)).to eq(%w(X O))
  end

  it 'should start with Round 1' do
    expect(game.instance_variable_get(:@round)).to eq(1)
  end

  it 'should start with turn order equal to normal' do
    expect(game.instance_variable_get(:@turn_order)).to eq('normal')
  end

  it 'should return false initially for game over' do
    expect(game.game_over).to eq(false)
  end

  it 'should return true for game_over if round 10 is reached' do
    game.instance_variable_set(:@round, 10)
    expect(game.game_over).to eq(true)
  end

  it 'should return true for game_over if a winner is detrimined' do
    game.instance_variable_set(:@winner, true)
    expect(game.game_over).to eq(true)
  end

  it 'should return true if the center square is open' do
    expect(game.center_empty?).to eq(true)
  end

  it 'should return true if corners are open' do
    expect(game.corner_empty?).to eq(true)
  end
end

describe 'Board' do
  board = Board.new

  it 'returns a board object' do
    expect(board).to be_an_instance_of Board
  end

  it 'should have a length of 9' do
    expect(board.grid.length).to eq(9)
  end

  it 'should contain only "-" ' do
    expect(board.grid.all? { |e| e == '-' }).to eq(true)
  end
end

describe 'Player' do
  player = Player.new

  it 'returns a Player object' do
    expect(player).to be_an_instance_of Player
  end
end
