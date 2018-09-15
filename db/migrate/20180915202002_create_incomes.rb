class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.string :date, null: false, default: ""
      t.decimal :total_amount, precision: 10, scale: 2
      t.decimal :remaining_balance, precision: 10, scale: 2
      t.integer :application_id, null: false, index: true

      t.timestamps
    end
  end
end
