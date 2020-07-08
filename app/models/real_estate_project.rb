class RealEstateProject < Poseidon::ActiveRecord
  belongs_to :building_list
  belongs_to :organisation
  has_one :investment_plan
  has_many :items, class_name: 'ProjectItem'
  has_many :project_items

  before_create :preload_from_list


  def line_totals
    self.items.sum(:total_cost)
  end

  def total_cost
    land_fees + service_fees + line_totals
  end

  def land_fees
    land_acquisition_fee + resettlement_compensation + land_transaction_fee
  end

  def service_fees
    land_fees + upfront_cost + planning_cost + survey_fee
  end

  def remaining_area
    available_area - items.sum('floor_space * plot_ratio')
  end

  def usage_percentage
    100 * (available_area - remaining_area) / available_area
  end


  def available_area
    land_area * plot_ratio
  end

  def name
    location
  end

  def preload_from_list
    building_list.items.each do |b|
      self.project_items << ProjectItem.new(real_estate_project: self, building_site: b.building_site, plot_ratio: b.plot_ratio, floor_space: land_area * b.portion / b.plot_ratio)
    end if building_list
  end

  def upfront_cost
    0
  end

  def planning_cost
    0
  end

  def survey_fee
    0
  end
end
