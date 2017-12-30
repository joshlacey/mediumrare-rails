class Tag < ApplicationRecord
  has_many :stories, through: :story_tags
end
