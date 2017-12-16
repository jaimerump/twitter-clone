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

  # Validations

  # Class methods

  # Instance methods

  # Syntactic sugar method for favoriting a tweet, because << and .delete look nothing alike
  def favorite_tweet(tweet)
    favorite_tweets << tweet
  end

  # Syntactic sugar method for removing a tweet from favorites, because << and .delete look nothing alike
  def unfavorite_tweet(tweet)
    favorite_tweets.delete(tweet)
  end
end
