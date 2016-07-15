class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :xbox_gamertag
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
