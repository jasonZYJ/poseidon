class SubCategory < Poseidon::ActiveRecord
  include Nameable

  belongs_to :category

end
