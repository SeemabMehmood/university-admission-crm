class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.integer :listening
      t.integer :speaking
      t.integer :reading
      t.integer :writing
      t.integer :overall
      t.string :type
      t.string :scanned_doc
      t.integer :applicant_id, index: true, null: false

      t.timestamps
    end
  end
end
