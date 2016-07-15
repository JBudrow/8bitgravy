require 'pry'
class UsersController < ApplicationController
  def new
    binding.pry
  end

  def create
    @user = User.new(user_params)
    # will have to add validation for gamertag availability
    # TODO refactor using xbox.rb from lib/
    @user.xuid = XboxApi::Client.new(ENV['X_AUTH']).gamer(@user.xbox_gamertag)

    if @user.save
      flash[:success] = "Register successful"
      redirect_to :root
    else
      render :new
    end
  end

  private
    def user_params
      params.permit(:xbox_gamertag, :email, :password)
    end
end
