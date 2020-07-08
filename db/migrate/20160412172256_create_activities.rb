class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :controller,:action,:state
      t.references :user,:organisation
      t.references :model,:context, polymorphic: true
      t.json :model_info
      t.timestamps null: false
    end
  end
end
