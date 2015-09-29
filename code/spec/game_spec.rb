require_relative '../lib/game'

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

  it 'should have a player object for player 1' do
    expect(game.instance_variable_get(:@player_1)).to be_an_instance_of Player
  end

  it 'should have a player object for player 2' do
    expect(game.instance_variable_get(:@player_2)).to be_an_instance_of Player
  end

  it 'should start with Round 1' do
    expect(game.instance_variable_get(:@round)).to eq(1)
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
end
