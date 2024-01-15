class ChangeDueDateTypeInExpenses < ActiveRecord::Migration[7.1]
  def change
    change_column :expenses, :due_date, :integer
  end
end
