# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication' do
  # GET /users/sign_in
  describe 'GET #sign_in' do
    subject(:get_sign_in) { get 'http://localhost:3000/users/sign_in' }

    it 'returns 200' do
      get_sign_in

      expect(response.status).to eq(200)
    end

    it 'returns a login form with a field for password' do
      get_sign_in

      expect(response.body).to include 'user_password'
    end
  end

  # POST /users/sign_in
  describe 'POST #sign_in' do
    subject(:post_sign_in) { post 'http://localhost:3000/users/sign_in', params: request_params }

    let(:request_params) { { user: { email: 'test@example.com', password: '123456' } } }

    context 'when there is no user with such credentials' do
      it 'returns alert' do
        post_sign_in

        expect(response.body).to include 'Invalid Email or password.'
      end
    end

    context 'when there is a user with such credentials' do
      before { create(:user, email: 'test@example.com', password: '123456') }

      it 'returns 302' do
        post_sign_in

        expect(response.status).to eq 302
      end

      it 'redirects to home page' do
        post_sign_in

        expect(response).to redirect_to '/'
      end
    end
  end
end
