# frozen_string_literal: true

# migration to create a table for transactions
class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :sender, null: false, foreign_key: { to_table: :bank_accounts }
      t.references :recipient, null: false, foreign_key: { to_table: :bank_accounts }
      t.string :uuid, null: false, index: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.timestamps
      t.check_constraint('amount >= 0', name: 'positive_amount_check')
    end
  end
end
