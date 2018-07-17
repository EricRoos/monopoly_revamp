FactoryBot.define do
  factory :invitation do
    association :user
    association :game
  end
end
