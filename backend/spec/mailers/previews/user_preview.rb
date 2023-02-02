# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def registration_confirmation
    UserMailer.with(user: FactoryBot.create(:user), token: 'foo').registration_confirmation.deliver_now
  end
  end
end
