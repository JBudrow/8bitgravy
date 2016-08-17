class CreatePlaystationGames < ActiveRecord::Migration
  def change
    create_table :playstation_games do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :np_communication_id
      t.string :url
      t.string :platform
      t.integer :defined_bronze
      t.integer :defined_silver
      t.integer :defined_gold 
      t.integer :defined_platinum
      t.integer :progress
      t.integer :earned_bronze
      t.integer :earned_silver
      t.integer :earned_gold
      t.integer :earned_platinum
      t.date :last_played
    end
  end
end
