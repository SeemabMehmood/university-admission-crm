class ChangeApplicationIdInIncomeTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :incomes, :application_id, true
  end
end
