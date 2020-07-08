# encoding: utf-8
class ShopImport < Poseidon::ActiveRecord
  include Importable

  after_create :import_shops

  belongs_to :organisation

  UNUSED_INDEX = [9, 13, 14]

  def import_shops
    return unless self.id
    # ImportJob.perform_now(self.id) ,Running Job still need sidekiq to work
    self.import!
  end

  def extra_options rows
    {building: rows.first.first}
  end

  def handle_columns(row)
    UNUSED_INDEX.each { |index| row.delete_at(index) }
    row[5, 1] = row[5].split('-')
    row
  end

  def handle_rows(rows)
    rows.keep_if { |r| r[4] && (r[4].to_f > 0.0) && r.size == 16 }
  end

  def mapping_columns
    %w(building	level	number bay depth min_height max_height bearing type feature	area category	sub_category	remark)
  end

  def association_columns
    %w(type category sub_category)
  end

  def build_data(import_data, organisation_id, options)
    objects = []
    category = Category.find_or_create_by(name: import_data[:category])
    sub_category = SubCategory.find_or_create_by(name: import_data[:sub_category], category_id: category.id)
    shop_type = ShopType.find_or_create_by(name: import_data[:type])
    objects << Shop.new(import_data.reject { |k, _| k==:category }.merge({organisation_id: organisation_id, building: options[:building], type: shop_type, sub_category: sub_category}))
    objects
  end

end
