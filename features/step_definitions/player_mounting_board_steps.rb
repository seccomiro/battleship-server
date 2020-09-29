Given('I have a board with dimensions {int} x {int}') do |width, height|
  create_my_player(board_height: height, board_width: width)
end

Given('I have a set of boats for that board') do
  @boats = @my_player.board.boats
end

Given('I have a first boat with size {int}') do |size|
  @first_boat = @my_player.board.boats.create(size: size)
end

Given('I have a test boat with size {int}') do |size|
  @test_boat = @my_player.board.boats.create(size: size)
end

When('I place each boat side by side from the biggest to the smallest, beginning from the top-left') do
  @boats.order(size: :desc).each_with_index do |boat, i|
    boat.place(:vertical, column: i, row: 0)
  end
end

Then('my private board should be: {string}') do |matrix_string|
  matrix = matrix_string.split('/').map { |row| row.split(',').map { |cell| cell == 'b' ? :boat : :water } }

  expect(@my_player.board.private).to match_array(matrix)
end

Then('there should be no boats left') do
  expect(@my_player.board.boats.docked.count).to eq(0)
end

Given('I have already placed the first boat') do
  @first_boat.place(:vertical, column: 0, row: 0)
end

When('I try to place the next boat overlapping at least one of the cells of the first boat') do
  @previous_board = @my_player.board.private
  @place_method = -> { @test_boat.place(:vertical, column: 0, row: 1) }
end

Then('I should be informed about the problem with a feedback about the overlapping cells') do
  expect { @place_method.call }
    .to raise_error(an_instance_of(Battleship::BoatPlacingError)
      .and(having_attributes(errors: match_array([{ row: 1, column: 0, type: :boat_overlapping }]))))
end

Then('the board should not change') do
  expect(@my_player.board.private).to match_array(@previous_board)
end

Then('the boat should not be placed') do
  expect(@test_boat.placed?).to be(false)
end

When('I try to place the boat from row {int}, column {int} and direction {string}') do |from_row, from_column, direction|
  @previous_board = @my_player.board.private
  @place_method = -> { @test_boat.place(direction.to_sym, column: from_column, row: from_row) }
end

Then('I should be informed about the problem with a feedback about the problematic cells') do
  expect { @place_method.call }.to raise_error(Battleship::BoatPlacingError)
end
