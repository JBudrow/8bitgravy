class User < ActiveRecord::Base
  has_secure_password
  has_many :xbox_games, dependent: :destroy
  has_many :steam_games, dependent: :destroy 
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
