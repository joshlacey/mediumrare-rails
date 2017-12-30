class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :description
      t.string :image_uri
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :email, null: false, unique: true
      t.json :links

      t.timestamps
    end
  end
end
