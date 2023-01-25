# frozen_string_literal: true

# Read more: https://github.com/cyu/rack-cors
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*'
    # , headers: ['Authorization'], expose: ['Authorization'], methods: :any
  end
end
