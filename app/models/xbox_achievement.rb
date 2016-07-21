class XboxAchievement < ActiveRecord::Base
  belongs_to :xbox_game

  def self.import_achievements xuid titleId
    response = XboxExtendedApi.get_achievements current_user[:xuid], titleId

    XboxAchievement.new name: response["name"],
                        time_unlocked:  DateTime.parse response["timeUnlocked"],
                        description: response["description"],
                        value: response["value"],
                        url: response["imageUnlocked"],
                        unlocked: response["unlocked"],
                        unlocked_online: response["unlockedOnline"]
  end
end
