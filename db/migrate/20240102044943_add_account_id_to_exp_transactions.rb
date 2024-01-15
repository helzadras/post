class AddAccountIdToExpTransactions < ActiveRecord::Migration[7.1.2] # Replace 6.0 with your Rails version
  def change
    add_reference(:exp_transactions, :account, null: false, foreign_key: true) unless column_exists?(:exp_transactions, :account_id)
  end
end
