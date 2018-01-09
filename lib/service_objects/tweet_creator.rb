# Service object to create tweets

class TweetCreator

  def self.run(tweet_params, user)
    mentions = TweetCreator.extract_mentions(tweet_params[:message])
    mentioned_users = User.where(screen_name: mentions)

    tweet = Tweet.create(message: tweet_params[:message], user: user)
    tweet.mentioned_users << mentioned_users

    tweet
  end

  # Find anything that looks like a username
  def self.extract_mentions(text)
     text.scan(/@([A-Za-z0-9\-_]+)/).flatten
  end

end