class AddIsSecretColumnToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :is_secret, :boolean
  end
end
