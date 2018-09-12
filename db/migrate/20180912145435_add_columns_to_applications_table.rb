class AddColumnsToApplicationsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :accommodation, :boolean, default: false
    add_column :applications, :medical, :boolean, default: false
    add_column :applications, :details_additional, :text
    add_column :applications, :statement_of_purpose, :text
    add_column :applications, :statement_of_purpose_doc, :string
  end
end
