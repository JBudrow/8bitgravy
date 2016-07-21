require 'pry'
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # User object
    @user = User.new user_params
    # XboxApi object
    @xbox_api_user = XboxApi::Client.new ENV['XBOX_AUTH']
    @xbox_api_user = @xbox_api_user.gamer @user[:xu_gamertag]
    @user.xuid = @xbox_api_user.xuid

    if @user.save
      flash[:success] = "Registration successful"
      redirect_to root_url
    else
      render :new
    end

    response = @xbox_api_user.xbox360games
    @unsorted_xbox360_library = response[:titles].map do |game|
      { name: game[:name],
        title_id: game[:titleId],
        last_played: game[:lastPlayed],
        current_achievements: game[:currentAchievements],
        current_gamerscore: game[:currentGamerscore],
        total_achievements: game[:totalAchievements],
        total_gamerscore: game[:totalGamerscore] }
    end

    @sorted_xbox360_library = @unsorted_xbox360_library.each do |game|
      @user.xbox_games.create name: game[:name],
        title_id: game[:title_id],
        last_played: game[:last_played],
        current_achievements: game[:current_achievements],
        current_gamerscore: game[:current_gamerscore],
        total_achievements: game[:total_achievements],
        total_gamerscore: game[:total_gamerscore]
    end
  end

  private
    def user_params
      params.require(:user).permit(:xu_gamertag, :email, :password)
    end
end
