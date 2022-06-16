# frozen_string_literal: true

require 'rails_helper'

describe TransferMoneyService do
  describe '#call' do
    subject(:call_service) { described_class.new(sender_uuid:, recipient_uuid:, amount:).call }

    context 'when transaction is not valid' do
      let(:amount) { -100 }
      let(:sender_uuid) { 'some uuid' }
      let(:recipient_uuid) { 'some other uuid' }

      it 'returns errors' do
        expect(call_service).to eq(
          { success: false,
            errors: ['Sender must exist', 'Recipient must exist', 'Amount must be greater than 0'] }
        )
      end
    end

    context 'when sender balance is less than amount of transfer' do
      let(:amount) { 100 }
      let(:sender_uuid) { create(:user).default_bank_account.uuid }
      let(:recipient_uuid) { create(:user, email: 'test2@example.com').default_bank_account.uuid }

      it 'returns errors' do
        expect(call_service).to eq(
          { success: false,
            errors: ['Balance must be greater than or equal to 0'] }
        )
      end
    end

    context 'when all requirements are satisfied' do
      let(:amount) { 100 }
      let(:sender_uuid) do
        bank_account = create(:user).default_bank_account
        bank_account.give_credit(100)
        bank_account.uuid
      end
      let(:recipient_uuid) { create(:user, email: 'test2@example.com').default_bank_account.uuid }

      it 'returns success true' do
        expect(call_service).to eq(
          { success: true,
            errors: [] }
        )
      end
    end
  end
end
