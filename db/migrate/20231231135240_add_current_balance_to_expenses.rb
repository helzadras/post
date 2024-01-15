class AddCurrentBalanceToExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :expenses, :current_balance, :decimal
  end
end