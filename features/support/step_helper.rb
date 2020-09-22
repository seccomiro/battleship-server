Given('a match already exists') do
  create_match
end

Given('I am a player named {string}') do |string|
  @my_player.name = string
  @my_player.save
end

Given('my opponent is a player named {string}') do |string|
  @opponent_player.name = string
  @opponent_player.save
end
