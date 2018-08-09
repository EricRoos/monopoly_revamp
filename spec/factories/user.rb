# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "member#{n}@mail.com" }
    password 'test123456'
  end
end
