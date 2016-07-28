class AddMultipleColumnsToXboxGames < ActiveRecord::Migration
  def change
    add_column :xbox_games, :genre, :string
    add_column :xbox_games, :sub_genre, :string
    add_column :xbox_games, :developer, :string
    add_column :xbox_games, :publisher, :string
    add_column :xbox_games, :release_date, :date
    add_column :xbox_games, :description, :text
    add_column :xbox_games, :hex_id, :string
    add_column :xbox_games, :box_art_url, :string
    add_column :xbox_games, :banner_url, :string 
  end
end
