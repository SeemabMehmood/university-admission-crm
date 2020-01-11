class AddPassportFileToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :passport_file, :string
  end
end
