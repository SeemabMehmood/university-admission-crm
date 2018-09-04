class ChangeDownloadCsvInUsersTable < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :download_csv, :string
    add_column :users, :download_csv, :integer, default: 0
  end

  def down
    remove_column :users, :download_csv, :integer
    add_column :users, :download_csv, :string, default: "allowed"
  end
end
