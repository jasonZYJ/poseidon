class Category < Poseidon::ActiveRecord
  include Nameable

  has_many :sub_categories
end
