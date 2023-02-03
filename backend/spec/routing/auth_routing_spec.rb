# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthController do
  describe 'routing' do
    it 'routes to #signup' do
      expect(post: '/auth/signup').to route_to('auth#signup')
    end

    it 'routes to #login' do
      expect(post: '/auth/login').to route_to('auth#login')
    end

    it 'routes to #logout' do
      expect(post: '/auth/logout').to route_to('auth#logout')
    end

    it 'routes to #confirm_email' do
      expect(get: '/auth/confirm_email').to route_to('auth#confirm_email')
    end
  end
end
