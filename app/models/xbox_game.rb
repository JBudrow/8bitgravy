class XboxGame < ActiveRecord::Base
  belongs_to :user
  has_many :achievements, dependent: :destroy

  # Users associated xbox model
  def self.current_users_xbox user
    XboxGame.find_by user_id: user.id
  end

  # XboxApi client object
  def self.client
    XboxApi::Client.new ENV["XBOX_AUTH"]
  end

  # XboxApi gamer object
  def self.gamer tag
    XboxGame.client.gamer tag
  end

  # Acquire XboxApi games
  def self.acquire_games api
    api.xbox360games
  end

  # Store XboxApi games
  def self.store_games api, user
    response = api.xbox360games

    response[:titles].map do |game|
      user.xbox_games.create name: game[:name],
        title_id: game[:titleId],
        hex_id: game[:titleId].to_i.to_s(16),
        last_played: game[:lastPlayed],
        current_achievements: game[:currentAchievements],
        current_gamerscore: game[:currentGamerscore],
        total_achievements: game[:totalAchievements],
        total_gamerscore: game[:totalGamerscore]
    end
  end
end
