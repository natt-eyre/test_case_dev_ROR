# frozen_string_literal: true

# this service creates a transaction and changes balances of a sender and a recipient
class TransferMoneyService
  def initialize(sender_uuid:, recipient_uuid:, amount:)
    @sender_uuid = sender_uuid
    @recipient_uuid = recipient_uuid
    @amount = amount.to_f
  end

  def call
    # these errors may not be descriptive enough for a user,
    # we can add some other messages later
    return { success: false, errors: transaction.errors.to_a } unless transaction.valid?

    sender_bank_account.balance -= amount
    return { success: false, errors: sender_bank_account.errors.to_a } unless sender_bank_account.valid?

    ActiveRecord::Base.transaction do
      transaction.save!
      sender_bank_account.save!
      recipient_bank_account.update!(balance: recipient_bank_account.balance + amount)
    end

    { success: true, errors: [] }
  end

  private

  attr_reader :sender_uuid, :recipient_uuid, :amount

  def recipient_bank_account
    @recipient_bank_account ||= BankAccount.find_by(uuid: recipient_uuid)
  end

  def sender_bank_account
    @sender_bank_account ||= BankAccount.find_by(uuid: sender_uuid)
  end

  def transaction
    @transaction ||=
      Transaction.new(sender_id: sender_bank_account&.id, amount:, recipient_id: recipient_bank_account&.id)
  end
end
