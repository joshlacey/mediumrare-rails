class Api::V1::UserFollowersController < ApplicationController


  def get_followers
    @followers = UserFollower.where(follower_id: follow_params[:follower_id]).map{|uf| uf.follower}
    render json: {followers: @followers}, status: 200
  end

  def get_followees
    @followees = UserFollower.where(followee_id: follow_params[:followee_id]).map{|uf| uf.followee}
    render json: {followees: @followees}, status: 200
  end

  def unfollow
    @follow = UserFollower.where(follower_id: follow_params[:follower_id]).where(followee_id: follow_params[:followee_id])
    if @follow.destroy
      render json: {message: "Unfollowed"}, status: 200
    else
      render json: {message: "something didn't work"}, status: 400
    end
  end

  def follow
    @follow = UserFollower.new(follow_params)
    if @follow.save
      render json: {follow: @follow}, status: 200
    else
      render json: {message: "Can't be followed at this time"}, status: 400
    end
  end

private
  def follow_params
    params.permit(:follower_id, :followee_id)
  end
end
