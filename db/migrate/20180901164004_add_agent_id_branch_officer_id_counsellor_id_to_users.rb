class AddAgentIdBranchOfficerIdCounsellorIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :agent_id, :integer, index: true
    add_column :users, :counsellor_id, :integer, index: true
    add_column :users, :branch_officer_id, :integer, index: true
  end
end
