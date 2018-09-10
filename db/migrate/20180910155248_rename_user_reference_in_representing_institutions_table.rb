class RenameUserReferenceInRepresentingInstitutionsTable < ActiveRecord::Migration[5.2]
  def up
    remove_reference :representing_institutions, :user, foreign_key: true
  end

  def down
    add_reference :representing_institutions, :user, foreign_key: true
  end
end
