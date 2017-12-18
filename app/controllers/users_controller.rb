class UsersController < ApplicationController
  
  # Show a user's profile
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user).includes(:user).all
  end

end
