class AddReferencesInRepresentingInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_reference :representing_institutions, :user, foreign_key: true
    add_reference :representing_institutions, :representing_country, foreign_key: true
  end
end
