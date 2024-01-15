class ChangeExpTransactionsAccountIdNullable < ActiveRecord::Migration[6.0]
  def change
    change_column :exp_transactions, :account_id, :integer, null: true
  end
end
