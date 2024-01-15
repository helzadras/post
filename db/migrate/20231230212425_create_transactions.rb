class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :source
      t.string :description
      t.decimal :amount
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :account, null: false, foreign_key: { on_delete: :cascade }
      t.references :expense, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
