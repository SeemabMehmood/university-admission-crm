class AddAgentIdInExpensesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :agent_id, :integer, null: false, index: true
  end
end
