class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.bigint :story_id, null: false
      t.bigint :user_id, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
