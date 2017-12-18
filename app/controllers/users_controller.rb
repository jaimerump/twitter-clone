class UsersController < ApplicationController
  
  # Show a user's profile
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user).order(created_at: :desc).includes(:user).all
  end

  # Follow a user
  def follow

    @user = User.find(params[:id])
    current_user.follow_user(@user)

    redirect_to user_path(@user)

  end

  # Unfollow a user
  def unfollow

    @user = User.find(params[:id])
    current_user.unfollow_user(@user)

    redirect_to user_path(@user)

  end

end
