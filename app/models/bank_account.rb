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
class BankAccount < ApplicationRecord
  belongs_to :user

  # only for testing purposes as the assessment asks for this ability in p. 4
  # it doesn't really work well with p.9 of the assessment that money can't just appear into account
  def give_credit(credit)
    update!(balance: balance + credit)
  end
end
