Given('a match already exists') do
  create_match(distribute_boats: true)
end

Given('I am a player named {string}') do |string|
  @my_player.name = string
  @my_player.save
end

Given('my opponent is a player named {string}') do |string|
  @opponent_player.name = string
  @opponent_player.save
end

Given('both players have already joined the match') do
  @my_player.join
  @opponent_player.join
end

Given("it's my turn to play") do
  @match.player_playing = @my_player

  expect(@match.player_playing).to eq(@my_player)
  expect(@my_player.playing?).to be(true)
  expect(@opponent_player.playing?).to be(false)
end

Given("it's not my turn to play") do
  @match.player_playing = @opponent_player

  expect(@match.player_playing).not_to eq(@my_player)
  expect(@my_player.playing?).to be(false)
  expect(@opponent_player.playing?).to be(true)
end
