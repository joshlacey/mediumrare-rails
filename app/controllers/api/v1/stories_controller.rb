class Api::V1::StoriesController < ApplicationController
  skip_before_action :authorized, only: [:show]
  before_action :check_user, only: [:create, :update]

  def create
    @story = Story.new(story_params)
    if @story.save
      render json: {story: @story}, status: 201
    else
      render json: {message: "story could not be saved"}, status: 400
    end
  end

  def index
    @stories = Story.all
    render json: {stories: @stories}, status: 200
  end

  def show
    @story = Story.find(params[:id])
    if @story
      render json: {story: @story, tags: @story.tags}, status: 200
    else
      render json: {message: "Story Not Found"}, status: 400
    end
  end

  def like
    if !is_owner
      @story = Story.find(params[:id])
      likes = @story.likes.to_i + 1
      @story.update(likes: likes)
      render json: {message: "#{@story.title} has been liked"}, status: 200
    else
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(story_params)
      render json: {story: @story}, status: 201
    else
      render json: {message: "Unable to update"}, status: 400
    end
  end

  def destroy
    @story = Story.find(params[:id])
    if current_user.id == @story.user_id
      @story.destroy
      render json: {message: "Your story has been deleted"}, status: 200
    else
      render json: {message: "You do not have permission to delete this post"}, status: 400
    end
  end

  private

  def story_params
    params.permit(:title, :user_id, body: [:html])
  end

  def is_owner
    story_params[:user_id].to_i == current_user.id
  end

  def check_user
    render json: {message: "Forbidden" }, status: 401 unless is_owner
  end
end
