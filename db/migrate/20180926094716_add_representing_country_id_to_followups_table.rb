class AddRepresentingCountryIdToFollowupsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :followups, :representing_country_id, :integer, null: false, index: true
  end
end
