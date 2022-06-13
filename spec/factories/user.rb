# frozen_string_literal: true

# Factory for the User class
FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { '123456' }
  end
end
