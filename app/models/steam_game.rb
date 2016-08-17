class SteamGame < ActiveRecord::Base
  belongs_to :user
  has_many :steam_achievements, dependent: :destroy 
end
