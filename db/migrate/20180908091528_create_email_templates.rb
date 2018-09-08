class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string :subject
      t.text :content
      t.references :application_process, foreign_key: true, index: true

      t.timestamps
    end
  end
end
