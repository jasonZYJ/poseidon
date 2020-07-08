class CreateWorkflowLogs < ActiveRecord::Migration
  def change
    create_table :workflow_logs do |t|
      t.references :document, polymorphic: true
      t.references :approver, :membership
      t.integer :rank, default: 0
      t.timestamps null: false
    end
  end
end
