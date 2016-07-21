class CreateXboxGames < ActiveRecord::Migration
  def change
    create_table :xbox_games do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :title_id
      t.date :last_played
      t.integer :current_achievements
      t.integer :current_gamerscore
      t.integer :total_achievements
      t.integer :total_gamerscore
    end
  end
end
