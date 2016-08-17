require 'pry'
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # Xbox client
    @user = User.new user_params
    @xbox_gamer = XboxGame.gamer @user.xu_gamertag
    @user.xuid = @xbox_gamer.xuid

    # Playstation client
    psn_gamer = PSNExtendedApi.new @user.psn_gamertag
    # @psn_library = psn_gamer.psn_games

    # Steam client
    SteamExtendedGamesApi.new @user, @user.steam_gamertag

    if @user.save
      XboxGame.store_games @xbox_gamer, @user
      psn_gamer.store_psn_games @user.playstation_games
      SteamExtendedAchievementsApi.new @user, @user.steamid

      flash[:success] = "Registration successful"
      redirect_to root_url
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit :xu_gamertag, :psn_gamertag, :steam_gamertag, :email, :password
    end
end
