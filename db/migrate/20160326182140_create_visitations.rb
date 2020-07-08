class CreateVisitations < ActiveRecord::Migration
  def change
    create_table :visitations do |t|
      t.references :creator, :contact
      t.references :context, polymorphic:true
      t.text :remark
      t.integer :duration
      t.timestamps null: false
    end
  end
end
