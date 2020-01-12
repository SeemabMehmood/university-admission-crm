class AddAgentIdInIncome < ActiveRecord::Migration[5.2]
  def change
    add_column :incomes, :agent_id, :integer
  end
end
