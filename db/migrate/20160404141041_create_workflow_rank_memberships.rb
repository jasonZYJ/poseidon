class CreateWorkflowRankMemberships < ActiveRecord::Migration
  def change
    create_table :workflow_rank_memberships do |t|
      t.references :workflow_rank, :role
      t.boolean :is_compulsory, default: false
      t.timestamps null: false
    end
  end
end
