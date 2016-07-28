class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
        t.references :xbox_game, index: true, foreign_key: true
        t.string :name
        t.string :url
        t.date :time_unlocked
        t.integer :value
        t.boolean :unlocked
        t.boolean :unlocked_online
        t.text :description
    end
  end
end
