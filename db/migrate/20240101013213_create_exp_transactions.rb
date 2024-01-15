class CreateExpTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :exp_transactions do |t|
      t.date :date
      t.string :source
      t.string :description
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
