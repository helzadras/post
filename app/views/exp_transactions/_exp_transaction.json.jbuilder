json.extract! exp_transaction, :id, :date, :source, :description, :amount, :user_id, :expense_id, :created_at, :updated_at
json.url exp_transaction_url(exp_transaction, format: :json)
