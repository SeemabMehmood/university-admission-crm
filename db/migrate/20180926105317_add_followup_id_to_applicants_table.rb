class AddFollowupIdToApplicantsTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :applicants, :application_id, true
    add_column :applicants, :followup_id, :integer, index: true
  end
end
