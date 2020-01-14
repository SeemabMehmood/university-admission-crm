class AddCreatedByToIncome < ActiveRecord::Migration[5.2]
  def change
    add_column :incomes, :created_by, :integer
  end
end
