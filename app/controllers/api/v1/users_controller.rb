class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      token = issue_token({ user_id: @user.id})
      render json: { user: @user, jwt: token}, status: 201
    else
      render json: {message: "Username is already taken" }, status: 400
    end
  end

  def show
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: {user: @user}, status: 201
    else
      render json: {message: "Unable to update"}, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {message: "Your account was deleted"}, status: 200
  end


private

  def user_params
    params.permit(:username, :password, :image_uri, :description, :email, links: [])
  end

end
