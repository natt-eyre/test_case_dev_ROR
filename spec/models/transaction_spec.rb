# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id           :bigint           not null, primary key
#  amount       :decimal(10, 2)   not null
#  uuid         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :bigint           not null
#  sender_id    :bigint           not null
#
# Indexes
#
#  index_transactions_on_recipient_id  (recipient_id)
#  index_transactions_on_sender_id     (sender_id)
#  index_transactions_on_uuid          (uuid)
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => bank_accounts.id)
#  fk_rails_...  (sender_id => bank_accounts.id)
#
require 'rails_helper'

describe Transaction do
  let(:user1) { create(:user) }
  let(:user2) { create(:user, email: 'test2@example.com') }

  describe '#create' do
    subject(:create_transaction) { described_class.create!(attributes) }

    before do
      user1.default_bank_account.update!(balance: 100)
    end

    let(:attributes) do
      { amount: 100, sender_id: user1.default_bank_account.id, recipient_id: user2.default_bank_account.id }
    end

    it 'creates a transaction in the database' do
      expect { create_transaction }.to change(described_class, :count).by(1)
    end
  end
end
