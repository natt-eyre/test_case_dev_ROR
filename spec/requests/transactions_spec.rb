# frozen_string_literal: true

require 'rails_helper'

describe 'Transactions' do
  # GET /transactions/new
  before do
    user = create(:user)
    user.default_bank_account.give_credit(100.25)
    sign_in user
  end

  describe 'GET #new' do
    subject(:to_new_transaction) { get 'http://localhost:3000/transactions/new' }

    it 'returns 200' do
      to_new_transaction

      expect(response.status).to eq 200
    end

    it 'returns a form to create a transaction' do
      to_new_transaction

      expect(response.body).to include '<form action="/transactions" accept-charset="UTF-8" method="post">'
    end
  end

  describe 'POST #create' do
    subject(:create_transaction) { post 'http://localhost:3000/transactions/', params: request_params }

    context 'with incorrect params' do
      let(:request_params) { { transaction: { bank_account_uuid: 'some uuid', amount: -2 } } }

      it 'returns 200' do
        create_transaction

        expect(response.status).to eq 200
      end

      it 'returns errors' do
        create_transaction

        expect(response.body).to include '<p class="alert">Recipient must exist, Amount must be greater than 0</p>'
      end
    end

    context 'with correct params' do
      let(:request_params) do
        { transaction: { bank_account_uuid: create(:user, email: 'test2@example.com').default_bank_account.uuid,
                         amount: 100.25 } }
      end

      it 'redirects to root' do
        create_transaction

        expect(response).to redirect_to(:root)
      end

      it 'returns notice about success' do
        create_transaction
        follow_redirect!

        expect(response.body).to include '<p class="notice">Success</p'
      end
    end
  end
end
