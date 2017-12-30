class ChangeFollowers < ActiveRecord::Migration[5.1]
  def change
    add_index :user_followers, :follower_id
    add_index :user_followers, :followee_id
    add_index :user_followers, [:follower_id, :followee_id], unique: true
  end
end
