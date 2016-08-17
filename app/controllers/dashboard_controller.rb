class DashboardController < ApplicationController
  before_action :authenticate
  def show
    render 'show'
  end
end
