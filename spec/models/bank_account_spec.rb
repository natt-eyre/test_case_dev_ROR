# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id         :bigint           not null, primary key
#  balance    :decimal(10, 2)   not null
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#  index_bank_accounts_on_uuid     (uuid)
#

# == Schema Information
#
# Table name: bank_accounts
#
#  id         :bigint           not null, primary key
#  balance    :decimal(10, 2)   not null
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#  index_bank_accounts_on_uuid     (uuid)
#
require 'rails_helper'

describe BankAccount do
  let(:user) { create(:user) }
  let(:bank_account) { user.bank_accounts.first }

  describe '#give_credit' do
    subject(:give_credit) { bank_account.give_credit(100) }

    it 'updates a balance of this bank account in the database' do
      expect { give_credit }.to change(bank_account, :balance).from(0).to(100)
    end
  end
end
