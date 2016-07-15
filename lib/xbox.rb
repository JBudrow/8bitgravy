class Xbox
  include HTTParty
  base_uri "https://xboxapi.com/v2/"

  def initialize
    # logan = XboxApi::Gamer.new("oh hai loganz", client, "189823798746")
    @headers = {
      "Authorization" => ENV["X_AUTH"],
      "User-Agent"    => "HTTParty"
    }
  end

  def extract_xuid(username)
    response = XboxApi::Client.new(ENV["X_AUTH"])
    xuid = response.gamer(username).xuid
  end

  def xbox_game_title_id(username)
    response = XboxApi::Client.new(ENV["X_AUTH"])
    xuid = response.gamer(username).xuid
    game_library = response.gamer(username).xbox360games

    # XboxApi.get("/#{xuid}/achievements/#{title_id}", headers: @headers)
  end


  def xbox_game_achievements(xuid, title_id)
    id = extract_xuid(xuid)

    # XboxApi.get("/#{id}/achievements/#{title_id}", headers: @headers)
  end
end
