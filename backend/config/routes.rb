# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices, only: %i[index show create] do
    post :send_email
  end

  get 'api-doc', to: 'documentation#api_doc' if Rails.env.development? || Rails.env.test?

  namespace :auth do
    post :signup
    get :confirm_email
  end
end
