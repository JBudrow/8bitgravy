class UsersController < ApplicationController
  def new
    User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Register successful"
      redirect_to @user
    else
      render :new
    end
  end

  private
    def user_params
      params.permit(:xbox_gamertag, :email, :password)
    end
end
