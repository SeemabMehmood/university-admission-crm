class CreateFollowups < ActiveRecord::Migration[5.2]
  def change
    create_table :followups do |t|
      t.string :date, null: false, default: ""
      t.text :description
      t.integer :status, default: 0
      t.integer :agent_id, null: false, index: true

      t.timestamps
    end
  end
end
