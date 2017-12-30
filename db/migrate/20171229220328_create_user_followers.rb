class CreateUserFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_followers do |t|
      t.bigint :follower_id, null: false
      t.bigint :followee_id, null: false

      t.timestamps
    end
  end
end
