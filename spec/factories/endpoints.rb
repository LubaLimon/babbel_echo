# frozen_string_literal: true

FactoryBot.define do
  factory :endpoint do
    verb { 'GET' }
    sequence(:path) { |n| "/random_url#{n}" }
    code { rand(0..999) }
    headers { { "fake": 'Header' } }
    body { 'Hello world' }
  end
end
