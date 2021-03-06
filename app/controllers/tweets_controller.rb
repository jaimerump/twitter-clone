class TweetsController < ApplicationController
  
  # Show a feed of tweets
  def index
    @tweets = Tweet.all.feed
  end

  # New tweet form
  def new
  end

  # Save new tweet
  def create
    # Injection risk, don't do this in production!
    @tweet = TweetCreator.run(params[:tweet], current_user)

    if @tweet.errors.any?
      respond_to do |format|
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "Tweet could not be saved" }
      end
    else
      respond_to do |format|
        format.json { render json: @tweet }
        format.html { redirect_to root_path, notice: "Tweet was saved" }
      end
    end

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

  # Favorite a tweet
  def favorite

    @tweet = Tweet.find(params[:id])
    current_user.favorite_tweet(@tweet)

    redirect_to params[:redirect] || root_path

  end

  # Unfavorite a tweet
  def unfavorite

    @tweet = Tweet.find(params[:id])
    current_user.unfavorite_tweet(@tweet)

    redirect_to params[:redirect] || root_path

  end

end
