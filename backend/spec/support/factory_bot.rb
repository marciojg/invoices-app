RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:all)  { FFaker::Random.seed = config.seed }
  config.before(:each) { FFaker::Random.reset! }
end
