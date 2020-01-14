class ChangeDateInFollowup < ActiveRecord::Migration[5.2]
  def change
    change_column :followups, :date, :string, null: false
  end
end
