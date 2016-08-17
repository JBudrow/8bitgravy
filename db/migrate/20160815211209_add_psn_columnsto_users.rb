class AddPsnColumnstoUsers < ActiveRecord::Migration
  def change
    add_column :users, :psn_gamertag, :string 
  end
end
