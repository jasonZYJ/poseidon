class WorkflowRankMembership < Poseidon::ActiveRecord
  belongs_to :role, required: true
  belongs_to :workflow_rank, required: true
  has_many :users, through: :role

  audited associated_with: :workflow_rank

  delegate :rank, to: :workflow_rank

  scope :compulsory, -> { where(is_compulsory: true) }
  scope :by_workflow, ->(w) { joins(:workflow_rank).where(workflow_ranks: {workflow_id: w.id}) }
  scope :by_user, ->(u) {joins(:users).where(users: {id: u.id})}

end