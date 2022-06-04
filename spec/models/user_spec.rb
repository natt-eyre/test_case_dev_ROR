# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '#create' do
    subject(:create_user) { described_class.create(attributes) }

    let(:attributes) { { email: 'test@example.com', password: '123456' } }

    it 'creates a user in the database' do
      expect { create_user }.to change(described_class, :count).by(1)
    end
  end
end
