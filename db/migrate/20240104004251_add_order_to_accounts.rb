# In your Account model migration file
class AddOrderToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :order, :integer
  end
end
