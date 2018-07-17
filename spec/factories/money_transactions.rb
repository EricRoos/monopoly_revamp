FactoryBot.define do
  factory :money_transaction do
    association :player
    amount 1
  end
end
