class ApplicationController < ActionController::Base
  before_action :set_current_account
  before_action :set_current_expense

  private

  def set_current_account
    account_id = params[:account_id] || params.dig(:acc_transaction, :account_id)
    @current_account = Account.find_by(id: account_id) || Account.first
  end

  def set_current_expense
    expense_id = params[:expense_id] || params.dig(:acc_transaction, :expense_id)
    @current_expense = Expense.find_by(id: expense_id)
  end
end
