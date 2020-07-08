class CreateWorkflowRanks < ActiveRecord::Migration
  def change
    create_table :workflow_ranks do |t|
      t.references :workflow
      t.integer :rank, :minimum_approvers, default: 0
      t.timestamps null: false
    end
  end
end
