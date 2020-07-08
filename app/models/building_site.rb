class BuildingSite < Poseidon::ActiveRecord
  include Nameable

  belongs_to :category
  has_many :contracts
  has_many :items, class_name: Contract


  def unit_cost
    contracts.sum(:unit_cost)
  end

end
