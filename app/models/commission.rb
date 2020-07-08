class Commission < Poseidon::ActiveRecord

  belongs_to :lease, required: true
  audited associated_with: :lease
end
