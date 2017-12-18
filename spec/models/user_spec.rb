# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  screen_name            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  
  # Build data
  let(:user) { create(:user) }
  
  # Hooks

  # Examples
  describe "#favorited_tweet?" do 

    # Build data
    let(:tweet) { create(:tweet, user_id: user.id) }

    # Hooks
    before(:each) do 
      user.favorites.clear
    end

    # Examples
    it "returns true if the user favorited the tweet" do 
      user.favorite_tweet(tweet)
      expect(user.favorited_tweet?(tweet)).to be true
    end

    it "returns false if the user hasn't favorited the tweet" do 
      user.favorites.clear
      expect(user.favorited_tweet?(tweet)).to be false
    end

  end

  describe "#favorite_tweet" do 

    # Build data
    let(:tweet) { create(:tweet, user_id: user.id) }

    # Hooks
    before(:each) do 
      user.favorites.clear
    end

    # Examples
    it "adds a tweet to favorites" do 
      user.favorite_tweet(tweet)

      expect(user.favorite_tweets).to include(tweet)
    end

    it "adds the tweet only once" do 
      old_count = user.favorite_tweets.size
      user.favorite_tweet(tweet)
      user.favorite_tweet(tweet)

      expect(user.favorite_tweets.reload.size).to be < old_count + 2
    end

  end

  describe "#unfavorite_tweet" do 

    # Build data
    let(:tweet) { create(:tweet, user_id: user.id) }

    # Hooks

    # Examples
    it "removes a tweet from favorites" do 
      user.favorite_tweet(tweet)
      user.unfavorite_tweet(tweet)

      expect(user.favorite_tweets).not_to include(tweet)
    end

  end

  describe "#following?" do 

    # Build data
    let(:other_user) { create(:user) }

    # Hooks
    before(:each) do 
      user.following.clear
    end

    # Examples
    it "returns true if the user favorited the other user" do 
      user.follow_user(other_user)
      expect(user.following?(other_user)).to be true
    end

    it "returns false if the user hasn't favorited the other user" do 
      user.following.clear
      expect(user.following?(other_user)).to be false
    end

  end

  describe "#follow_user" do 

    # Build data

    # Hooks
    before(:each) do 
      user.followers.clear
      user.following.clear
    end

    # Examples
    it "follows a user" do
      other_user = create(:user) 
      user.follow_user(other_user)

      expect(user.following.reload).to include(other_user)
    end

    it "adds the user only once" do 
      other_user = create(:user) 
      old_count = user.following.size
      user.follow_user(other_user)
      user.follow_user(other_user)

      expect(user.following.reload.size).to be < old_count + 2
    end

  end

  describe "#unfollow_user" do 

    # Build data

    # Hooks

    # Examples
    it "unfollows a user" do 
      other_user = create(:user) 
      user.follow_user(other_user)
      user.unfollow_user(other_user)

      expect(user.following.reload).not_to include(other_user)
    end

  end

end
