class AccTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :account

  def calculate_available_balance
    account.current_balance - account.expenses.sum(:funds)
  end
end
