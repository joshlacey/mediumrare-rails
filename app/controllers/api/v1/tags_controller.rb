class Api::V1::TagsController < ApplicationController
  before_action :check_user, only: [:tag_story, :delete_tag]

  def get_tagged_story_ids
    @tag = Tag.find_by(name: params[:tag])
    if @tag
      render json: {story_tags: @tag.stories}, status: 200
    else
      render json: {message: "There are no stories tagged #{params[:tag]}"}, status: 400
    end
  end

  def tag_story
    @story_tags = tag_params[:tag_names].map do |tag|
      @tag = Tag.find_or_create_by(name: tag)
      StoryTag.find_or_create_by(story_id: params[:id], tag_id: @tag.id)
    end
    if @story_tags.length
      render json: {story_tag: @story_tags}, status: 200
    else
      render json: {message: "not all of the tags were saved"}, status: 400
    end
  end

  def delete_tag
    @tag = Tag.find_by(name: params[:tag])
    if @tag
      @storytag = StoryTag.find_by(story_id: params[:id], tag_id: @tag.id)
      if @storytag
        @storytag.destroy
        render json: {message: 'untagged'}, status: 200
      end
    else
    end


  end

private

  def tag_params
    params.permit(:name, tag_names: [])
  end

  def is_owner
    @story = Story.find(params[:id])
    @story.user_id == current_user.id
  end

  def check_user
    render json: {message: "Forbidden" }, status: 401 unless is_owner
  end

end
