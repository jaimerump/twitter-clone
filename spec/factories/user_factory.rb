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

FactoryBot.define do
  
  factory :user do
    name "Joe"
    sequence(:screen_name) { |n| "joe_#{n}" }
    sequence(:email) { |n| "joe_#{n}@gmail.com" }
    password "test_password"
  end
end
