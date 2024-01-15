class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :creditor
      t.string :purpose
      t.decimal :initial_balance
      t.decimal :interest
      t.decimal :funds
      t.date :due_date
      t.integer :terms
      t.decimal :amount_due
      t.references :account, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
