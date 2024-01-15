class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :acc_transactions, dependent: :destroy
  has_many :exp_transactions, dependent: :destroy
  has_many :account_transactions, class_name: 'AccTransaction', dependent: :destroy
  has_many :expense_transactions, class_name: 'ExpTransaction', dependent: :destroy

  def calculate_available_balance
    current_balance.to_f - expenses.sum(:funds).to_f
  end
end
