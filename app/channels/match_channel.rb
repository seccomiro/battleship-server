class MatchChannel < ApplicationCable::Channel
  def subscribed
    match = Match.find(params[:match_id])
    match.players.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
