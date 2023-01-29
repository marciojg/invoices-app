# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :token_digest
      t.string :renew_token_digest
      t.boolean :email_confirmed, default: false
      t.string :confirm_token

      t.timestamps
    end
  end
end
