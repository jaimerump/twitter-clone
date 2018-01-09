class UsersController < ApplicationController
  
  before_action :fetch_user

  # Show a user's profile
  def show
    @tweets = Tweet.where(user: @user).order(created_at: :desc).includes(:user).all
  end

  # Follow a user
  def follow
    current_user.follow_user(@user)
    redirect_to user_path(@user)
  end

  # Unfollow a user
  def unfollow
    current_user.unfollow_user(@user)
    redirect_to user_path(@user)
  end

  # Show user's mentions
  def mentions
    @tweets = @user.mentions.order(created_at: :desc).includes(:user).all
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

end
