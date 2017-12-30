class User < ApplicationRecord
  has_many :user_followers, class_name: "UserFollower", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :user_followers
  has_many :stories, dependent: :destroy
  has_secure_password
  validates_presence_of [:username, :email, :password_digest]

end
