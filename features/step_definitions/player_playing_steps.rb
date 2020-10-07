Given('my opponent has a board') do
  @opponent_player.board
end

When('I ask the match for the public board') do
  @opponent_public_board = @opponent_player.board.public
end

Then('I should receive his public board') do
  expect(@opponent_public_board).not_to be_nil
end

Then('all its cells should be closed') do
  expect(@opponent_player.board.new?).to be(true)
end

Given("I know my opponent's public board") do
  @opponent_public_board = @opponent_player.board.public
end

Given("it's my turn to play") do
  @match.player_playing = @my_player

  expect(@match.player_playing).to eq(@my_player)
  expect(@my_player.playing?).to be(true)
  expect(@opponent_player.playing?).to be(false)
end

Then('I try to guess a closed cell') do
  expect(@my_player.opponent.board.public[0][0]).to eq(:new)
  @result = @my_player.guess(row: 0, column: 0)
end

Then('I should get a valid return') do
  original_value = @opponent_player.board.private[0][0]
  expect(@result).to eq(original_value)
end
