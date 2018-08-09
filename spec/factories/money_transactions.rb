# frozen_string_literal: true

FactoryBot.define do
  factory :money_transaction do
    association :player
    amount 1
  end
end
