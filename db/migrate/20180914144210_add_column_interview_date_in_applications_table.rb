class AddColumnInterviewDateInApplicationsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :interview_date, :string, null: false, default: ""
  end
end
