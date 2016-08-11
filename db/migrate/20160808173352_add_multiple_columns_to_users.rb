class AddMultipleColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :steamid, :string
    add_column :users, :steam_gamertag, :string
    add_column :users, :steam_vanity_url, :string 
    add_column :users, :avatar, :string
    add_column :users, :avatar_medium, :string
    add_column :users, :avatar_full, :string
  end
end
