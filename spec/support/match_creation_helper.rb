def create_match(board_height: 10, board_width: 10, players: [:my, :opponent], distribute_boats: false)
  @match = create(:match)

  create_my_player(board_height: board_height, board_width: board_width) if players == :my || (players.respond_to?(:include?) && players.include?(:my))
  create_opponent_player(board_height: board_height, board_width: board_width) if players == :opponent || (players.respond_to?(:include?) && players.include?(:opponent))
  if distribute_boats
    distribute_my_boats if @my_player
    distribute_opponent_boats if @opponent_player
  end
end

def create_my_user
  @my_user = create(:user, email: 'user1@user.com', name: 'User 1')
end

def create_opponent_user
  @opponent_user = create(:user, email: 'user2@user.com', name: 'User 2')
end

def create_my_player(board_height: 10, board_width: 10)
  create_my_user
  @my_player = create(:player, match: @match, user: @my_user)
  @my_player.create_board(height: board_height, width: board_width)
end

def create_opponent_player(board_height: 10, board_width: 10)
  create_opponent_user
  @opponent_player = create(:player, match: @match, user: @opponent_user)
  @opponent_player.create_board(height: board_height, width: board_width)
end

def distribute_my_boats
  @my_player.board.boats.order(size: :desc).each_with_index do |boat, i|
    boat.place(:vertical, column: i, row: 0)
  end
end

def distribute_opponent_boats
  @opponent_player.board.boats.order(size: :desc).each_with_index do |boat, i|
    boat.place(:vertical, column: i, row: 0)
  end
end
