# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:all) { FFaker::Random.seed = config.seed }
  config.before { FFaker::Random.reset! }
end
