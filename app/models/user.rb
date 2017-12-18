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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable,
         :validatable

  # ActiveRecord relationships
  has_many :tweets, inverse_of: :user
  has_many :favorites, inverse_of: :user
  has_many :favorite_tweets, through: :favorites, 
                             source: :tweet
  # Followers
  has_many :followed_follows, class_name: 'Follow',
                              foreign_key: 'followed_id',
                              inverse_of: :followed 
  has_many :followers, through: :followed_follows,
                       source: :follower 
  # Following
  has_many :follower_follows, class_name: 'Follow',
                              foreign_key: 'follower_id',
                              inverse_of: :follower 
  has_many :following, through: :follower_follows,
                       source: :followed

  # Validations
  validates :name, presence: true 
  validates :screen_name, presence: true, uniqueness: true

  # Class methods

  # Instance methods

  # Whether the user has favorited the given tweet
  def favorited_tweet?(tweet)
    favorite_tweets.include? tweet
  end

  # Syntactic sugar method for favoriting a tweet, because << and .delete look nothing alike
  def favorite_tweet(tweet)
    # Ternary to prevent duplicates
    favorited_tweet?(tweet) ? favorite_tweets : favorite_tweets << tweet
  end

  # Syntactic sugar method for removing a tweet from favorites, because << and .delete look nothing alike
  def unfavorite_tweet(tweet)
    favorite_tweets.delete(tweet)
  end

  # Whether the user is following the given user
  def following?(user)
    following.include? user
  end

  # Syntactic sugar method for following a user, because << and .delete look nothing alike
  def follow_user(user)
    # Ternary to prevent duplicates
    following?(user) ? following : following << user
  end

  # Syntactic sugar method for unfollowing a user, because << and .delete look nothing alike
  def unfollow_user(user)
    following.delete(user)
  end

end
