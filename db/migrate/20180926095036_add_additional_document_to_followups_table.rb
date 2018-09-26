class AddAdditionalDocumentToFollowupsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :followups, :additional_document, :string
  end
end
