require 'uri'
class PSNExtendedApi
  include HTTParty
  base_uri "http://psnapi-studio51.rhcloud.com/PSN/"
  def initialize psn_gamertag
    @psn_gamertag = psn_gamertag
    @headers = { "User-Agent" => "HTTParty" }
  end

  # PlayStation user information
  def psn_user #user
    PSNExtendedApi.get "/#{@psn_gamertag}", headers: @headers
  end

  def store_psn_user user
    response = psn_user
    user[:psn_gamertag] = response['onlineId']
  end

  # PlayStation games meta
  def psn_games
    PSNExtendedApi.get "/#{@psn_gamertag}/trophies", headers: @headers
  end

  def store_psn_games game
    response = psn_games
    response['trophyTitles'].map do |attribute|
      game.find_or_create_by name: attribute['trophyTitleName'],
        np_communication_id: attribute['npCommunicationId'],
        url: attribute['trophyTitleIconUrl'],
        platform: attribute['trophyTitlePlatfrom'],
        defined_bronze: attribute['definedTrophies']['bronze'],
        defined_silver: attribute['definedTrophies']['silver'],
        defined_gold: attribute['definedTrophies']['gold'],
        defined_platinum: attribute['definedTrophies']['platinum'],
        progress: attribute['comparedUser']['progress'],
        earned_bronze: attribute['comparedUser']['earnedTrophies']['bronze'],
        earned_silver: attribute['comparedUser']['earnedTrophies']['silver'],
        earned_gold: attribute['comparedUser']['earnedTrophies']['gold'],
        earned_platinum: attribute['comparedUser']['earnedTrophies']['platinum'],
        last_played: attribute['comparedUser']['lastUpdateDate']
    end
  end

  # PlayStation trophies
  def psn_trophies
    PSNExtendedApi.get "/{#{@psn_gamertag}/trophies/#{np_communication_id}", headers: @headers
  end

  def store_trophies trophy
    response = psn_trophies np_communication_id
    response['trophies'].map do |attribute|
      trophy.new name: attribute['trophyName'],
        detail: attribute['trophyDetail'],
        type: attribute['trophyType'],
        url: attribute['trophyIconUrl'],
        rarity: attribute['trophyRare'],
        earned_rate: attribute['trophyEarnedRate'],
        is_hidden: attribute['trophyHidden'],
        earned: attribute['comparedUser']['earned'],
        time_unlocked: attribute['comparedUser']['earnedDate']
    end
  end
end
