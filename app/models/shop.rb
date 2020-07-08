class Shop < Poseidon::ActiveRecord
  include Copyable
  include Mergable
  include Restricted

  belongs_to :sub_category, required: true
  belongs_to :type, class_name: 'ShopType'
  belongs_to :organisation, required: true
  belongs_to :workflow
  belongs_to :parent, class_name: 'Shop'

  has_many :agreements
  has_many :leases
  has_many :visitations
  has_many :children, class_name: 'Shop', foreign_key: 'parent_id'

  delegate :brand, to: :lease, allow_nil: true
  validates :number, :building, presence: true

  scope :unmerged, -> { where(parent_id: nil) }

  attr_accessor :category

  class << self
    def mergable_attributes
      %w(number area)
    end

    def generate_excel
      excel = [%w(building level number bay depth max_min_height bearing type feature covered_area area category subcategory	operation_type brand remark)]
      uncached do
        find_each do |s|
          excel << get_excel_row(s)
        end
      end
      excel
    end

    def get_excel_row(shop)
      [shop.building, shop.level, shop.number, shop.bay, shop.depth, "#{shop.min_height}-#{shop.max_height}", shop.bearing, shop.type.name, shop.feature,'', shop.area, shop.sub_category.try(:category).try(:name), shop.sub_category.try(:name),'','', shop.remark]
    end
  end

  def to_s
    "#{building} - #{level} - #{number}"
  end

  def active_lease
    @active_lease ||= leases.active.first
  end

  def pending_agreements
    agreements.open
  end

  def merge(shop)
    self.class.mergable_attributes.each do |a|
      assign_attributes({"#{a}" => merge_attribute(send(a), shop.send(a))})
    end
    self
  end

  def split
    children.each { |c| c.update_attribute(:parent, nil) }
    self
  end

  def name_column
    :number
  end

end
