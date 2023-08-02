# frozen_string_literal: true

Rails.application.routes.draw do
  resources :endpoints, defaults: {format: :json}
  match '*path' => 'mocks#show', via: :all, defaults: {format: :json}
end
