class Visitation < Poseidon::ActiveRecord
  belongs_to :creator, class_name: 'User', required: true
  belongs_to :contact
  belongs_to :context, polymorphic: true
  audited associated_with: :context
end
