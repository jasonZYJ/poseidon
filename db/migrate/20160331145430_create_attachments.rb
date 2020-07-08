class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :context, polymorphic:true
      t.references :creator, :updator
      t.string :file_file_name, :file_content_type, :caption
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.timestamps null: false
    end
  end
end
