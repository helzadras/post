class AddBudgetToExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :expenses, :budget, :decimal
  end
end
