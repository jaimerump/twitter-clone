require 'rails_helper'
require 'spec_helper'

RSpec.describe TweetCreator do
  
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe ".run" do 

    it "creates a tweet" do 
      tweet = TweetCreator.run({ message: "Blah" }, user1)
      expect(Tweet.last.message).to eq(tweet.message)
    end

    context "if the message includes an @mention" do 

      it "creates a mention" do 
        tweet = TweetCreator.run({ message: "Blah @#{user2.screen_name}" }, user1)
        expect(tweet.mentioned_users.reload).to include(user2)
      end

      it "only creates mentions for valid usernames" do 
        tweet = TweetCreator.run({ message: "Blah @invalid" }, user1)
        expect(tweet.mentioned_users).to be_empty
      end

    end

  end 

  describe ".extract_mentions" do 

    it "matches anything that looks like a username" do 
      expect(TweetCreator.extract_mentions("Blah blah @test blah")).to eq(["test"])
    end

  end

end