class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.bigint :user_id, null: false
      t.json :body
      t.bigint :likes

      t.timestamps
    end
  end
end
