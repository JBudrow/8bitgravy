require 'pry'
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @gamer = XboxGame.gamer @user.xu_gamertag
    @user.xuid = @gamer.xuid
    if @user.save
      XboxGame.store_games @gamer, @user
      flash[:success] = "Registration successful"
      redirect_to root_url
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit :xu_gamertag, :email, :password
    end
end
