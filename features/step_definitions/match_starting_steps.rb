When('the match is asked to begin') do
  @match.begin
end

Then('it should draw the starting player') do
  @drawn_player = @match.player_playing
end

Then('the starting player should be one of the players attached to the match') do
  expect(@drawn_player).to eq(@my_player).or(eq(@opponent_player))
end

Then('the status of the match should be set to being played') do
  expect(@match.being_played?).to be(true)
end
