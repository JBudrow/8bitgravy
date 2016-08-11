class CreateSteamGames < ActiveRecord::Migration
  def change
    create_table :steam_games do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :appid
      t.integer :playtime_forever
      t.string :playtime_2weeks
      t.string :img_icon_url
      t.string :img_logo_url
      t.boolean :has_community_visible_stats
    end
  end
end
