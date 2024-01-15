class ChangeExpTransactionsUserIdNullable < ActiveRecord::Migration[6.0]
  def change
    change_column :exp_transactions, :user_id, :integer, null: true
  end
end
