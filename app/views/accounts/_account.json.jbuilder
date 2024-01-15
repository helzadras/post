json.extract! account, :id, :name, :current_balance, :available_balance, :user_id, :created_at, :updated_at
json.url account_url(account, format: :json)
