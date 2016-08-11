require 'pry'
class XboxGamesController < ApplicationController
  # set before action for updating game table via show?
  before_action :authenticate
  include XboxGamesHelper

  def index
    binding.pry 
    @custom_api = XboxExtendedApi.new
    @games = current_user.xbox_games.page(params[:page]).per 12
  end

  def show
    @custom_api = XboxExtendedApi.new
    @game = XboxGame.find params[:id]
    @custom_api.game_meta @game.hex_id, @game
    @custom_api.achievement_meta current_user.xuid, @game.title_id, @game
  end
end
