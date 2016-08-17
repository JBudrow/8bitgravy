class PlaystationGame < ActiveRecord::Base
  belongs_to :user
  has_many :playstation_trophies
end
