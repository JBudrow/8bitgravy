class Achievement < ActiveRecord::Base
  belongs_to :xbox_game

  # # Collect game title id response
  # achievement_response = game_response[:titles].map do |game|
  #   { title_id: game[:titleId] }
  # end
  #
  # # Acquire achievement response
  # acquire_achievement_response = achievement_response.map do |title|
  #   @xbox_extended_api_user.get_achievements(@user.xuid,title[:title_id].to_s)
  # end
  #
  # # Collect achievement response
  # collect_achievement_response = acquire_achievement_response[0].map do |achievement|
  #   { name: achievement["name"],
  #     url: achievement["imageUnlocked"],
  #     unlocked_online: achievement["unlockedOnline"],
  #     unlocked: achievement["unlocked"],
  #     value: achievement["gamerscore"],
  #     time_unlocked: achievement["timeUnlocked"],
  #     description: achievement["description"] }
  # end
  #
  # # Store achievement response
  # collect_achievement_response.each do |attribute|
  #   Achievement.create name: attribute[:name],
  #     url: attribute[:url],
  #     unlocked_online: attribute[:unlocked_online],
  #     unlocked: attribute[:unlocked],
  #     value: attribute[:value],
  #     time_unlocked: attribute[:time_unlocked]
  # end
end
