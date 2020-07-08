class BuildingList < Poseidon::ActiveRecord
  has_many :items, class_name: 'BuildingListItem'
  has_many :building_list_items
end
