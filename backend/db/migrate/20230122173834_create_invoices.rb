# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: :uuid do |t|
      t.integer :number, null: false
      t.date :reference_date, null: false
      t.text :company_data, null: false
      t.text :billing_data, null: false
      t.monetize :value, null: false
      t.string :emails, array: true, default: []

      t.timestamps
    end
  end
end
