class Brand < Poseidon::ActiveRecord
  include Nameable

  belongs_to :sub_category
  belongs_to :organisation
end
