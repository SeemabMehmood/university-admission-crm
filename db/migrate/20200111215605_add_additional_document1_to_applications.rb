class AddAdditionalDocument1ToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :additional_document_1, :string
    add_column :applications, :additional_document_2, :string
  end
end
