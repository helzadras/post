class Expense < ApplicationRecord
  belongs_to :account #, optional: true  # Allow nil for account_id
  belongs_to :user
  has_many :exp_transactions

  before_validation :ensure_negative_values

  validates :default_fund_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  private
  
  def ensure_negative_values
    self.initial_balance = -initial_balance.abs if initial_balance.present?
    self.current_balance = -current_balance.abs if current_balance.present?
    self.amount_due = -amount_due.abs if amount_due.present?
    # Add more fields if needed
  end
  
  #validates :amount_due, presence: true
  #validates :due_date, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 31 }
end
