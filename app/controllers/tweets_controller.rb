class TweetsController < ApplicationController
  
  # Show a feed of tweets
  def index
    @tweets = Tweet.includes(:user).all
  end

  # New tweet form
  def new
  end

  # Save new tweet
  def create
  end

  # Edit tweet form
  def edit
  end

  # Save updated tweet
  def update
  end

  # Delete tweet
  def destroy
  end

end
