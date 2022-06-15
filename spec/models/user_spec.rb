# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

describe User do
  describe '#create' do
    subject(:create_user) { described_class.create(attributes) }

    let(:attributes) { { email: 'test@example.com', password: '123456' } }

    it 'creates a user in the database' do
      expect { create_user }.to change(described_class, :count).by(1)
    end

    it 'creates a bank account in the database' do
      expect { create_user }.to change(BankAccount, :count).by(1)
    end
  end
end
