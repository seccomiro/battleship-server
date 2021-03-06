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

Given('I want to guess at [{int},{int}]') do |row, column|
  @guess = -> { @my_player.guess(row: row, column: column) }
end

When('I try to guess at [{int},{int}]') do |row, column|
  @original_value = @opponent_player.board.private[row][column]
  @original_opponent_public_board = @opponent_player.board.public

  @result = @guess.call
end

Then('I should get a valid return') do
  expect(@result).to eq(@original_value)
end

Given('it is ensured that the cell at [{int},{int}] has a boat') do |row, column|
  expect(@my_player.opponent.board.private[row][column]).to eq(:boat)
end

Then('I should be informed that I hit a boat') do
  expect(@result).to eq(:boat)
end

Then("my opponent's public board should be updated with that guess for [{int},{int}]") do |row, column|
  @original_opponent_public_board[row][column] = @result

  expect(@my_player.opponent.board.public[row][column]).to eq(@result)
  expect(@my_player.opponent.board.public).to match_array(@original_opponent_public_board)
end

Given('the cell at [{int},{int}] is closed') do |row, column|
  expect(@my_player.opponent.board.public[row][column]).to eq(:new)
end

Given('it is ensured that the cell at [{int},{int}] does not have a boat') do |row, column|
  expect(@my_player.opponent.board.private[row][column]).not_to eq(:boat)
end

Then('I should be informed that I hit the water') do
  expect(@result).to eq(:water)
end

When('I try to guess at any position') do
  @guess = -> { @my_player.guess(row: 0, column: 0) }
end

Then("I should be informed with an error saying that it's not my turn to play") do
  expect { @guess.call }.to raise_error(Battleship::OtherUserTurnError)
end
