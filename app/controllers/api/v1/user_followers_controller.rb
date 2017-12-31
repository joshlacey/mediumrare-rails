class Api::V1::UserFollowersController < ApplicationController
  skip_before_action :authorized, only: [:get_followers, :get_followees]

  def get_followers
    @followers = UserFollower.where(followee_id: params[:id]).map{|uf| uf.follower}
    render json: {followers: @followers}, status: 200
  end

  def get_followees
    @followees = UserFollower.where(follower_id: params[:id]).map{|uf| uf.followee}
    render json: {followees: @followees}, status: 200
  end

  def unfollow
    @follow = UserFollower.where(follower_id: current_user.id).where(followee_id: params[:id]).first
    if @follow
      @follow.destory
      render json: {message: "Unfollowed"}, status: 200
    else
      render json: {message: "something didn't work"}, status: 400
    end
  end

  def follow
    if valid_user(params[:id])
      if params[:id].to_i != current_user.id
        @follow = UserFollower.new(followee_id: params[:id], follower_id: current_user.id)
        begin
          @follow.save
          render json: {follow: @follow}, status: 200
        rescue
          render json: {message: "Can't be followed at this time"}, status: 400
        end
      else
        render json: {message: "You can't follow yourself"}, status: 400
      end
    else
      render json: {message: "Invalid user"}, status: 400
    end
  end

private
  def follow_params
    params.permit(:follower_id, :followee_id)
  end

  def valid_user(id)
    begin
       User.find(id)
       true
     rescue
       false
    end
  end
end
