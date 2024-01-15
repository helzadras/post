class ChangeAccountNullableInExpenses < ActiveRecord::Migration[6.0] # Adjust the version based on your Rails version
  def change
    change_column :expenses, :account_id, :bigint, null: true
  end
end
