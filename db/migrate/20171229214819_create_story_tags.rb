class CreateStoryTags < ActiveRecord::Migration[5.1]
  def change
    create_table :story_tags do |t|
      t.bigint :story_id, null: false
      t.bigint :tag_id, null: false

      t.timestamps
    end
  end
end
