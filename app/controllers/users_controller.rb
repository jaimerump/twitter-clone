class UsersController < ApplicationController
  
  # Show a user's profile
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user).order(created_at: :desc).includes(:user).all
  end

end
