class AddDefaultFundAmountToExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :expenses, :default_fund_amount, :decimal
  end
end
