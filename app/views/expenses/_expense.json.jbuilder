json.extract! expense, :id, :creditor, :purpose, :initial_balance, :interest, :funds, :due_date, :terms, :amount_due, :account_id, :user_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
