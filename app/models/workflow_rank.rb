class WorkflowRank < Poseidon::ActiveRecord
  has_many :workflow_rank_memberships
  has_many :memberships, class_name: 'WorkflowRankMembership'
  belongs_to :workflow, required: true

  audited associated_with: :workflow

  acts_as_list scope: :workflow, column: :rank

  scope :by_rank, ->(r) { where(rank: r) }


  def next_approving_agents(approved_users)
    compulsory_users = all_compulsory_roles.map(&:users) - approved_users
    (compulsory_users.present? || approved_users.size < minimum_approvers) ? (all_approvers - approved_users) : (lower_item.try(:all_approvers) || [])
  end

  def all_compulsory_roles
    @compulsory_roles ||= memberships.compulsory.map(&:role)
  end

  def all_approval_roles
    @approval_roles ||= memberships.map(&:role)
  end

  def all_approvers
    @approval_users ||= all_approval_roles.map{|r| r.role_users.map(&:user)}.flatten
  end

  def is_ready_for?(members)
    members.count >=  minimum_approvers && (all_compulsory_roles - members.map(&:role)).empty?
  end

  def to_s
    "#{workflow.name}_#{rank}"
  end
end
