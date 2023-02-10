# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices, only: %i[index show create] do
    post :send_email
  end

  namespace :auth do
    post :login
    post :logout
    post :signup
    get :confirm_email
  end
end
