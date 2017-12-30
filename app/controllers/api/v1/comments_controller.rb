class Api::V1::CommentsController < ApplicationController

  def get_all
    @comments = Comment.where(story_id: params[:story_id])
    render json: {comments: @comments}, status: 201
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {comment: @comment}, status: 201
    else
      render json: {message: "You can't comment at this time"}, status: 400
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      render json: {message: "Comment Deleted"}, status: 200
    else
      render json: {message: "You are not allowed to delete this comment"}, status: 400
    end
  end

  private

  def comment_params
    params.permit(:user_id, :story_id, :content)
  end
end
