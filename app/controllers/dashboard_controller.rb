require 'pry'
class DashboardController < ApplicationController
  before_action :authenticate
  def index
    # @client = XboxExtendedApi.new
    # @xuid = @client.gamertag_xuid(current_user[:xu_gamertag])
    # @game_ids = @client.xbox360_games_titleIds @xuid
    # @game_ids = Dashboard.page(params[:page])
  end
end
