class Workflow < Poseidon::ActiveRecord
  include Restricted

  audited

  belongs_to :owner, :class_name => 'Organisation', required: true
  has_many :workflow_ranks, -> { order(:rank) }, :dependent => :destroy, :autosave => true
  has_many :workflow_rank_memberships, through: :workflow_ranks

  has_associated_audits

  alias_attribute :ranks, :workflow_ranks

  scope :owned_by, ->(o) { where(:owner_id => o) }


  def next_approving_rank(approved_logs)
    current_rank = approved_logs.first.try(:workflow_rank)
    current_rank ? current_rank.next_approving_agents(approved_logs.map(&:approver)) : workflow_ranks.first.all_approvers
  end

  def advance(document)
    logs = document.workflow_logs
    highest = logs.order(:rank).last.membership.workflow_rank
    highest.is_ready_for?(logs.by_rank(highest.rank).map(&:membership)) && highest.last?
  end

  def to_s
    name
  end
end