require 'pry'
require 'HTTParty'
class SteamExtendedGamesApi
  def initialize user
    # Get Vanity URL id for single player
    steam_hash = HTTParty.get "http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/",
                              :query => { 'key' => ENV['STEAM_AUTH'], 'vanityurl' => user.steam_gamertag }
    # Get account summary for single player
    user.steamid = steam_hash['response']['steamid']
    player = SteamWebApi::Player.new user.steamid
    data = player.summary.to_h[:profile]
    data.collect do |meta|
      User.find_or_create_by id: user.id,
         steam_gamertag: meta[3],
         steam_vanity_url: user,
         avatar: meta[6],
         avatar_medium: meta[7],
         avatar_full: meta[8]
    end
    user.save
  end

  # Get Steam identifier for user
  def store_steam_games user
    player = SteamWebApi::Player.new user.steamid
    steam_api = player.owned_games(include_played_free_games: true, include_appinfo: true).games
    steam_api.collect do |game|
      SteamGame.find_or_create_by user_id: user.id,
        appid: game['appid'],
        name: game['name'],
        playtime_2weeks: game['playtime_2weeks'],
        playtime_forever: game['playtime_forever'],
        img_icon_url: game['img_icon_url'],
        img_logo_url: game['img_logo_url'],
        has_community_visible_stats: game['has_community_visible_stats']
    end
  end
end
