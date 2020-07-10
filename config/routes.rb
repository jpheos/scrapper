# frozen_string_literal: true

Rails.application.routes.draw do
  resources :areas
  get  'pushbullet/callback'
  get  'pushbullet/init'
  get  'pushbullet/devices'
  post 'pushbullet/devices/pick', to: 'pushbullet#devices_pick'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'areas#index'
end
