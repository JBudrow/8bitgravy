class CreatePlaystationTrophies < ActiveRecord::Migration
  def change
    create_table :playstation_trophies do |t|
      t.references :playstation_game, index: true, foreign_key: true
      t.string :name
      t.string :detail
      t.string :type
      t.string :url
      t.integer :rarity
      t.string :earned_rate
      t.boolean :earned
      t.date :time_unlocked 
      t.boolean :is_hidden
    end
  end
end
