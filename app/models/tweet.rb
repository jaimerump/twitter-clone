# == Schema Information
#
# Table name: tweets
#
#  id                :integer          not null, primary key
#  message           :string
#  link              :string
#  user_id           :integer          not null
#  reply_to_id       :integer
#  original_tweet_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Tweet < ApplicationRecord

  # ActiveRecord relationships
  belongs_to :user, inverse_of: :tweets
  # Direct replies
  belongs_to :reply_to, class_name: 'Tweet', 
                        inverse_of: :direct_replies, 
                        optional: true
  has_many :direct_replies, class_name: 'Tweet', 
                            inverse_of: :reply_to,
                            foreign_key: :reply_to_id
  # Ancestor tweet, used to avoid reddit problem of having to iterate every level of replies to build a thread
  belongs_to :original_tweet, class_name: 'Tweet', 
                              inverse_of: :all_replies, 
                              optional: true
  has_many :all_replies, class_name: 'Tweet', 
                         inverse_of: :original_tweet,
                         foreign_key: :original_tweet_id
  # Favorites
  has_many :favorites, inverse_of: :tweet
  has_many :favorited_users, through: :favorites,
                             source: :user 
                             # class_name: 'User'

  # Validations
  validates :user, presence: true

  # Class methods

  # Instance methods

end
