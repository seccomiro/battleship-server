Given("the board of both players has only one closed public cell remaining") do
  create_match(board_height: 1, board_width: 1)
  @my_player.board.boats.build(size: 1).place(:square, column: 0, row: 0)
  @opponent_player.board.boats.build(size: 1).place(:square, column: 0, row: 0)
end

When('I guess at the closed cell') do
  @my_player.guess(row: 0, column: 0)
end

Then('I should be the winner of the match') do
  expect(@match.winner).to eq(@my_player)
end

Then('the match should be finished') do
  expect(@match.finished?).to be(true)
end

Then('my opponent should be the loser of the match') do
  expect(@match.loser).to eq(@opponent_player)
end

When('my opponent guesses at the closed cell') do
  @opponent_player.guess(row: 0, column: 0)
end

Then('I should be the loser of the match') do
  expect(@match.loser).to eq(@my_player)
end

Then('my opponent should be the winner of the match') do
  expect(@match.winner).to eq(@opponent_player)
end
