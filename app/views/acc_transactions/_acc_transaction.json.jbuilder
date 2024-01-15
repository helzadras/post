json.extract! acc_transaction, :id, :date, :source, :description, :amount, :user_id, :account_id, :created_at, :updated_at
json.url acc_transaction_url(acc_transaction, format: :json)
