class CreateMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :money_transactions do |t|
      t.references :player, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
