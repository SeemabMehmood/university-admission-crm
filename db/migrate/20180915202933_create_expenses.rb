class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :date, null: false, default: ""
      t.decimal :paid, precision: 10, scale: 2
      t.string :reason, null: false, default: ""

      t.timestamps
    end
  end
end
