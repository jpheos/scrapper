# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pushbullet/callback'
  get 'pushbullet/init'
  get 'pushbullet/devices'
  post 'pushbullet/devices/pick', to: 'pushbullet#devices_pick'
  post '/json_entries/:id/refresh', to: 'json_entries#refresh', as: 'json_entry_refresh'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :areas do
    resources :json_entries, only: %i[index new create]
  end

  resources :json_entries, only: %i[edit update destroy show]

  resources :items, only: %i[index]

  root to: 'areas#index'
end
