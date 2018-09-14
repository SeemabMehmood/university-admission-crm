class RenameTypeColumnInLanguages < ActiveRecord::Migration[5.2]
  def change
    rename_column :languages, :type, :test_type
  end
end
