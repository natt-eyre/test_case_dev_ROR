# frozen_string_literal: true

# create table for bank_accounts
class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.belongs_to :user, null: false
      t.string :uuid, null: false, index: true
      t.decimal :balance, null: false, precision: 10, scale: 2
      t.timestamps
      t.check_constraint('balance >= 0', name: 'positive_balance_check')
    end
  end
end
