# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :posts do
    resources :comments, controller: 'comments', only: %i[create]
  end
end
