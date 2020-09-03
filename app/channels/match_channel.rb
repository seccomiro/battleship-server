class MatchChannel < ApplicationCable::Channel
  def subscribed
    set_match_and_player

    stream_from "match_#{@match.id}"
    stream_from "player_#{@player.id}"
  rescue ActiveRecord::RecordNotFound
    reject
  end

  def join(data)
    player_id = data['player_id']

    ActionCable.server.broadcast "player_#{player_id}",
                                 message: 'Welcome to Battleship'
  end

  def unsubscribed
  end

  private

  def set_match_and_player
    @match = Match.find(params[:match_id])
    @player = @match.players.find_by_user_id!(params[:user_id])
  end
end
