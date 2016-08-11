class SteamExtendedAchievementsApi
  def initialize user, steamid
    # Get user achievements for game
    player = SteamWebApi::Player.new steamid
    game_ids = user.steam_games.pluck :appid
    steam_game = SteamGame.find_by(user_id: user.id)
    steam_game_meta = game_ids.map {|id| player.achievements(id)[:achievements]}
    steam_game_meta_compact = steam_game_meta.compact.flatten
    steam_game_meta_compact.map do |achievement|
      SteamAchievement.find_or_create_by steam_game_id: steam_game.id,
        name: achievement['apiname'],
        achieved: achievement['achieved']
    end

    # Get game schema
    # game = SteamWebApi::Gamenew gameid
    # schema = game.schema
  end
end
