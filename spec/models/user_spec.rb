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
  let(:user) { build(:user) }
  
  # Hooks

  # Examples
  describe "#favorite_tweet" do 

    # Build data
    let(:tweet) { build(:tweet) }

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
    let(:tweet) { build(:tweet) }

    # Hooks

    # Examples
    it "removes a tweet from favorites" do 
      user.favorite_tweet(tweet)
      user.unfavorite_tweet(tweet)

      expect(user.favorite_tweets).not_to include(tweet)
    end

  end

end
