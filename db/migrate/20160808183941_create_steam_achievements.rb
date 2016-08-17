class CreateSteamAchievements < ActiveRecord::Migration
  def change
    create_table :steam_achievements do |t|
      t.references :steam_game, index: true, foreign_key: true
      t.string :name
      t.string :default_value
      t.string :display_name
      t.string :description
      t.string :icon
      t.string :icon_gray
      t.string :percent
      t.integer :hidden
      t.integer :achieved
      t.timestamps
    end
  end
end
