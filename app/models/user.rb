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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # NOTE: if there are too many transactions user deletion can become slow
  # can switch to delete or destroy_async later
  has_many :bank_accounts, dependent: :destroy

  # NOTE: I assumed that as it's a banking app every user would need to have at least one bank account
  # the moment it's been created so I added this callback
  # if business logic of user creation becomes more difficult
  # we should replace callbacks on user creation with builder object
  # and may be do some slow steps asynchronously
  after_create :create_bank_account

  def create_bank_account
    bank_accounts.create!(uuid: SecureRandom.uuid, balance: 0)
  end
end
