class RemoveColumnCounsellorsIdFromRepresentingInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :representing_institutions, :counsellor_id, :integer, index: true, foreign_key: true
  end
end
