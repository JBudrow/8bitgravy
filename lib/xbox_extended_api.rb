require 'uri'
class XboxExtendedApi
  include HTTParty
  base_uri "https://xboxapi.com/v2"
  default_params :output => 'json'
  format :json
  def initialize
    @headers = {
      "X-Auth"     => ENV["XBOX_AUTH"],
      "User-Agent" => "HTTParty"
    }
  end

  def self.get_gamercard xuid
    response = get("/#{xuid}/gamercard", headers: @headers)
    encoded_url(response)
  end

  def self.get_gamertag_xuid gamertag
    url = "https://xboxapi.com/v2/xuid/#{gamertag}"
    encoded = URI.encode url
    get("#{encoded}", headers: @headers)
  end

  def self.get_achievements xuid, titleId
    get("/#{xuid}/achievements/#{titleId}", headers: @headers)
  end

  def self.get_friends xuid
    get("/#{xuid}/friends", headers: @headers)
  end

  def self.get_xbox360_games xuid
    response = get("/#{xuid}/xbox360games", headers: @headers)
  end

  def self.get_games_titles games_data
    games_data[:titles].map do |game|
      game[:name]
    end
  end
end
