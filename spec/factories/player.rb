FactoryGirl.define do
  factory :player do
    user
    league { League.find_or_create_by(name: 'league') }
  end
end
