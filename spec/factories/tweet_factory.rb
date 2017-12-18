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

FactoryBot.define do
  
  factory :tweet do
    message "Testing"
    user_id 1
  end
end
