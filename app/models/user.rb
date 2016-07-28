class User < ActiveRecord::Base
  has_secure_password
  has_many :xbox_games, dependent: :destroy 
  # accepts_nested_attributes_for :xbox_games
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
