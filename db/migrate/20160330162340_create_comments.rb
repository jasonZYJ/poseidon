class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic:true
      t.references :creator, :updator
      t.text :body
      t.boolean :is_private
      t.timestamps null: false
    end
  end
end
