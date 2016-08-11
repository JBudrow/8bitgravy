require 'HTTParty'
class SteamExtendedGamesApi
  def initialize user, vanity
    steam_hash = HTTParty.get "http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/",
                              :query => { 'key' => ENV['STEAM_AUTH'], 'vanityurl' => vanity }
    steam_id = steam_hash['response']['steamid']
    player = SteamWebApi::Player.new steam_id
    data = player.summary.to_h[:profile]
    user.update_attributes steamid: data['steamid'],
       steam_gamertag: data['personaname'],
       steam_vanity_url: vanity,
       avatar: data['avatar'],
       avatar_medium: data['avatarmedium'],
       avatar_full: data['avatarfull']

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
