class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:tweet_id]
      current_user.likes.create(tweet_id: params[:tweet_id])
    elsif params[:answer_id]
      current_user.likes.create(answer_id: params[:answer_id])
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if params[:tweet_id]
      like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
      like&.destroy
    elsif params[:answer_id]
      like = Like.find_by(answer_id: params[:answer_id], user_id: current_user.id)
      like&.destroy
    end
    redirect_back(fallback_location: root_path)
  end
end