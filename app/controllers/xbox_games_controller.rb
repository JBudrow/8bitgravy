require 'pry'
class XboxGamesController < ApplicationController
  before_action :authenticate
  include XboxGamesHelper

  def index
    @custom_api = XboxExtendedApi.new
    @games = current_user.xbox_games.page(params[:page]).per 12
  end

  def show
    @game = XboxGame.find id: params[:id]
  end
end
