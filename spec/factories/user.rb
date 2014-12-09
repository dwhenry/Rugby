FactoryGirl.define do
  factory :user do
    sequence :login do |n|
      "test_#{n}"
    end
    sequence :email do |n|
      "test_#{n}@email.com"
    end
    sequence :name do |n|
      "test_#{n}"
    end
    password 'password'
    password_confirmation 'password'
  end
end
