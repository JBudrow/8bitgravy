require 'uri'
class XboxExtendedApi
  include HTTParty
  base_uri "https://xboxapi.com/v2"
  format :json
  def initialize
    @headers = {
      "X-Auth"     => ENV["XBOX_AUTH"],
      "User-Agent" => "HTTParty"
    }
  end

  # Xbox games
  def games xuid
    XboxExtendedApi.get("/#{xuid}/xbox360games", headers: @headers)
  end

  # Xbox achievements
  def achievements xuid, titleId
    XboxExtendedApi.get("/#{xuid}/achievements/#{titleId}", headers: @headers)
  end

  # Xbox game meta
  def meta hexId
    XboxExtendedApi.get("/game-details-hex/#{hexId}", headers: @headers)
  end

  # Strip all but digits in unix timestamp
  def convert_time date
    extract_digits = date.scan(/\d+/).first
    converted_unix = extract_digits.to_i / 1000
    Time.at converted_unix
  end

  # Sort and collect Xbox game meta
  def game_meta hexId, game
    response = meta hexId

    response["Items"].map do |attribute|
      game.update_attributes genre: attribute["Genres"][0]["Name"],
                             publisher: attribute["PublisherName"],
                             developer: attribute["DeveloperName"],
                             release_date: convert_time(attribute["ReleaseDate"]),
                             description: attribute["ReducedDescription"]
    end
  end

  # Acquire Xbox game's achievements
  def achievement_meta xuid, titleId, game
    response = achievements xuid, titleId

    response.map do |attribute|
      game.achievements.new          name: attribute["name"],
                                     url: attribute["imageUnlocked"],
                                     unlocked_online: attribute["unlockedOnline"],
                                     unlocked: attribute["unlocked"],
                                     value: attribute["gamerscore"],
                                     time_unlocked: attribute["timeUnlocked"],
                                     description: attribute["description"],
                                     is_secret: attribute["isSecret"]
    end
  end

  # Acquire Xbox game's image url
  def image_meta hexId
    response = meta hexId
    nested_image = response["Items"].map { |attribute| attribute["Images"] }
    sort_image = nested_image.flatten.delete_if { |hash| hash["Height"] != 300 }
    url = sort_image[0]["Url"]
  end
end
