class ProjectItem < Poseidon::ActiveRecord

  attr_accessor :item_percentage,:available_area

  belongs_to :real_estate_project
  belongs_to :building_site

  delegate :land_area, to: :real_estate_project, allow_nil: :ture
  delegate :category , to: :building_site, allow_nil: :ture

  validates :building_site, presence: true

  after_initialize :calculate_derived_fields

  before_save :set_total_cost


  def calculate_derived_fields
    self.available_area = floor_space*plot_ratio
    self.item_percentage = 100 * available_area / real_estate_project.available_area
  end

  def pre_config project
    self.real_estate_project = project
    self.available_area = project.remaining_area
    self.plot_ratio = project.plot_ratio
    self.floor_space = available_area / plot_ratio
    self.item_percentage = 100 * available_area / real_estate_project.available_area
  end

  def name
    building_site.name
  end

  def set_total_cost
    self.total_cost = unit_price * floor_space * plot_ratio
  end

end
