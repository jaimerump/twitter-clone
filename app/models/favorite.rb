# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  tweet_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Favorites are implemented as a join model instead of a join table because I've found that I always need timestamps
class Favorite < ApplicationRecord
  
  # ActiveRecord relations
  belongs_to :tweet, inverse_of: :favorites
  belongs_to :user, inverse_of: :favorites

  # Validations
  validates :tweet, presence: true
  validates :user, presence: true

end
