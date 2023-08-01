# frozen_string_literal: true

Rails.application.routes.draw do
  resources :endpoints
  match '*path' => 'mocks#show', via: :all
end
