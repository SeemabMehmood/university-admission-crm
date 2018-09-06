class AddAgentIdToRepresentingCountriesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :representing_countries, :agent_id, :integer, index: true, null: false
  end
end
