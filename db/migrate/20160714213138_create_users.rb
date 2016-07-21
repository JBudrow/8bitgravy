class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :xu_gamertag
      t.string  :xuid, :limit => 16
      t.string  :email
      t.string  :password_digest

      t.timestamps null: false
    end
  end
end
