class WorkflowLog < Poseidon::ActiveRecord

  belongs_to :approver,  class_name: 'User', foreign_key: :approver_id, required: true
  belongs_to :membership, class_name: 'WorkflowRankMembership', required: true
  belongs_to :document,  polymorphic: true, required: true


  before_save :set_rank

  delegate :workflow_rank, to: :membership

  scope :by_rank, ->(r) {where(rank: r)}

  def set_rank
    self.rank = membership.workflow_rank.rank
  end

end
