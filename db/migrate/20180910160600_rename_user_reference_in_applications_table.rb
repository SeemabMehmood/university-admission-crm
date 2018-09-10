class RenameUserReferenceInApplicationsTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :applications, :user, foreign_key: true, index: true
    add_column :applications, :counsellor_id, :integer, index: true, null: false
  end
end
