# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    association :game
    association :user
  end
end
