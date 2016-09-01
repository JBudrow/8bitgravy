require 'pry'
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # User client
    @user = User.new user_params

    # Xbox client
    xbox_gamer = XboxExtendedApi.new @user.xu_gamertag

    # Playstation client
    psn_gamer = PSNExtendedApi.new @user.psn_gamertag

    # Steam client
    steam_gamer = SteamExtendedGamesApi.new @user

    if @user.save
      xbox_gamer.store_games @user.xu_gamertag, @user
      psn_gamer.store_psn_games @user.playstation_games
      steam_gamer.store_steam_games @user

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
