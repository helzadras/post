class ChangeAccountDefaultInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column_default :transactions, :account_id, 0  # You can set a different default value
  end
end
