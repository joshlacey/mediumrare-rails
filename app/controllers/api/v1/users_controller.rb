class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :destroy]

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
     render json: {user: @user}, status: 201
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update_attributes(user_params)
      render json: {user: @user}, status: 201
    else
      render json: {message: "Unable to update"}, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
     begin
       render json: {message: "Your account was deleted"}, status: 200
     rescue => detail
       detail.backtrace.each do |m|
         puts m
       end
      end
    else
      render json: {message: "You cannot delete this account"}, status: 400
    end
  end

  def

private

  def user_params
    params.permit(:username, :password, :image_uri, :description, :email, links: [])
  end

end
