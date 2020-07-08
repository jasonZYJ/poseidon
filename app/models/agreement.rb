class Agreement < Poseidon::ActiveRecord
  include Contractual
  include AgreementStates

  belongs_to :shop, required: true
  belongs_to :brand, required: true
  has_one :lease

  alias_attribute :organisation, :first_party
  alias_attribute :tenant, :second_party
  alias_attribute :owner, :organisation

  delegate :workflow, to: :shop, allow_nil: true
  before_validation :set_tenant

  def set_tenant
    self.first_party ||= shop.organisation
    self.second_party ||= brand.organisation
  end

  def number_prefix
    'AG'
  end

  def to_s
    "#{number}  #{first_party}  -  #{second_party}"
  end
end
