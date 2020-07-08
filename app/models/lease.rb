class Lease < Poseidon::ActiveRecord
  include Contractual
  include LeaseStates
  include DateRanged

  belongs_to :agreement, required: true
  belongs_to :shop, required: true
  belongs_to :brand, required: true
  belongs_to :workflow
  has_many :workflow_logs, -> { order(:rank) }, as: :document
  has_many :commissions


  before_save :copy_from_agreement

  alias_attribute :organisation, :first_party
  alias_attribute :tenant, :second_party
  alias_attribute :owner, :organisation

  validates :start_date, :end_date, presence: true
  validate :shop_available
  validate :date_range


  scope :active, -> { where('now() between start_date and end_date') }

  def copy_from_agreement
    if agreement_id_changed?
      %w(shop brand first_party second_party workflow).each do |a|
        send("#{a}=", agreement.send(a))
      end
    end
    self
  end

  def create_approval_log
    class_for(:workflow_logs).create(document: self,)
  end

  def next_approvers
    approving_rank = highest_approved_rank
    workflow.next_approving_rank(workflow_logs.by_rank(approving_rank))
  end

  def highest_approved_rank
    workflow_logs.maximum(:rank)
  end

  def do_approve(user)
    log_user_approvals(user)
    workflow.advance(self)
  end

  def log_user_approvals(user)
    # if the last rank's user approve, then it means the whole workflow is approved.
    workflow.workflow_rank_memberships.by_user(user).each { |m| class_for(:workflow_logs).where(approver: user, document: self, membership: m).first_or_create }
  end

  def pending_agreements
    shop.agreements.open
  end

  def total_value
    (end_date - start_date).round * daily_rate
  end

  def shop_available
    if shop.active_lease && shop.active_lease.end_date < start_date
      errors.add(:base, "#{shop} has been rented out until #{shop.active_lease.end_date}")
    end
  end


  protected
  def number_prefix
    'LS'
  end
end
