class RenameCounsellorIdTouserIdInApplciationsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :branch_officer_id, :integer, index: true, null: false, default: 0
    add_column :applications, :agent_id, :integer, index: true, null: false, default: 0
    change_column :applications, :counsellor_id, :integer, index: true, null: false, default: 0
  end
end
