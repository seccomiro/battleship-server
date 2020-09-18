Given('both players have already joined the match') do
  @my_player.join
  @opponent_player.join
end

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
  pending # Write code here that turns the phrase above into concrete actions
end

When("it's my turn to play") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be able to choose a closed cell') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should get a valid return') do
  pending # Write code here that turns the phrase above into concrete actions
end
