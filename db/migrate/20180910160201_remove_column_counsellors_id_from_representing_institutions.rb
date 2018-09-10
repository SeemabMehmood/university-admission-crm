class RemoveColumnCounsellorsIdFromRepresentingInstitutions < ActiveRecord::Migration[5.2]
  def change
    remove_column :representing_institutions, :counsellors_id, :integer, index: true, foreign_key: true
  end
end
