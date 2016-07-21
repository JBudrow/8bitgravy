class XboxGame < ActiveRecord::Base
  belongs_to :user

  def game_library
  end

  def self.import_games xuid
    response = XboxExtendedApi.xbox360_games user[:xuid]
    XboxGame.new name: response["name"],
                 title_id: response["titleId"],
                 last_played: DateTime.parse(response["lastPlayed"]),
                 current_achievements: response["currentAchievements"],
                 current_gamescore: response["currentGamerscore"],
                 total_achievements: response["totalAchievements"],
                 total_gamerscore: response["totalGamerscore"]
  end
end
