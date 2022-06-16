# frozen_string_literal: true

# users can transfer money to each other through this controller
class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = Transaction.new
  end

  def create
    result = TransferMoneyService.new(sender_uuid: current_user.default_bank_account.uuid,
                                      recipient_uuid: transaction_params[:bank_account_uuid],
                                      amount: transaction_params[:amount]).call

    if result[:success]
      redirect_to :root, notice: 'Success'
    else
      flash.now[:alert] = result[:errors].join(', ')
      render :new
    end
  end

  protected

  def transaction_params
    params.require(:transaction).permit(:bank_account_uuid, :amount)
  end
end
