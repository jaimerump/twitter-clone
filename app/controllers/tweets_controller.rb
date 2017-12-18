class TweetsController < ApplicationController
  
  # Show a feed of tweets
  def index
    @tweets = Tweet.includes(:user).all.order(created_at: :desc)
  end

  # New tweet form
  def new
  end

  # Save new tweet
  def create
    # Injection risk, don't do this in production!
    @tweet = Tweet.create(message: params[:tweet][:message], user: current_user)

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

end
