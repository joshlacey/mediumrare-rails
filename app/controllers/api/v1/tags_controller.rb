class Api::V1::TagsController < ApplicationController

  def get_tagged_story_ids
    @tag = Tag.find_by(tag_params[:name])
    @tagged_story_ids = StoryTag.where(tag_id: @tag.id).map{|s| s.story_id }
    render json: {story_tags: @tagged_stories}, status: 200
  end

  def create
    #I think the only time I would need to create is when tagging a story
  end

  def tag_story
    @story_tags = tag_params[:tag_names].map do |tag|
      @tag = Tag.find_or_create_by(name: tag)
      StoryTag.new(story_id: params[:id], tag_id: @tag.id)
    end
    saved = @story_tags.each{ |st| st.save ?  true : false }.reduce(:&)
    if saved
      render json: {story_tag: @story_tags}, status: 200
    else
      render json: {message: "not all of the tags were saved"}, status: 400
    end
  end

private

  def tag_params
    params.permit(:name, tag_names: [])
  end
end
