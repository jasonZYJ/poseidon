class BuildingListItem < Poseidon::ActiveRecord
  belongs_to :list, class_name: 'BuildingList', foreign_key: 'building_list_id'
  belongs_to :building_site

  validates :building_site,:list, presence: true
  delegate :name, to: :building_site, allow_nil: true
end
