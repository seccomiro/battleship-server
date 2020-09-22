Given('two players are already attached to the match') do
  expect(@match.players.count).to eq(2)
end

Given('the match is ready to be played by the players') do
  expect(@match.ready?).to be(true)
end

Given('I am not yet playing') do
  expect(@match.players.joined).not_to include(@my_player)
end

When('I enter a match') do
  @confirmed = @my_player.join
end

Then('I should know that my sign in is confirmed') do
  expect(@confirmed).to be true
  expect(@my_player.joined_at).not_to be_nil
end

Then('I should see {string}') do |string|
  expect(@my_player.full_logs).to include(string)
end

When('my opponent should see {string}') do |string|
  expect(@opponent_player.full_logs).to include(string)
end

Given('no players have joined a match yet') do
  expect(@match.players.joined.count).to eq(0)
end

Given('another player have already joined a match') do
  @opponent_player.join
  expect(@match.players.joined.count).to eq(1)
end
