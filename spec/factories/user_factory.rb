FactoryBot.define do
  
  factory :user do
    name "Joe"
    sequence(:screen_name) { |n| "joe_#{n}" }
    sequence(:email) { |n| "joe_#{n}@gmail.com" }
    password "blah"
  end
end