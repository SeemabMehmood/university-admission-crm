class AddMajorToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :major, :string
  end
end
