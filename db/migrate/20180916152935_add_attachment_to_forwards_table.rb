class AddAttachmentToForwardsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :forwards, :attachment, :string
  end
end
