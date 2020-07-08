class CreateDocumentCounters < ActiveRecord::Migration
  def change
    create_table :document_counters do |t|
      t.references :organisation
      t.integer :counter, default: 0
      t.string :document_type
      t.timestamps null: false
    end
  end
end
