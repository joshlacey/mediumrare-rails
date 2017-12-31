class User < ApplicationRecord
  validates_presence_of [:username, :email, :password_digest]
  has_secure_password
  has_many :user_followers, class_name: "UserFollower", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :user_followers
  has_many :stories, dependent: :destroy

end
