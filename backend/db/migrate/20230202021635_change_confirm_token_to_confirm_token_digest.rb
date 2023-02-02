# frozen_string_literal: true

class ChangeConfirmTokenToConfirmTokenDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :confirm_token, :confirm_token_digest
  end
end
