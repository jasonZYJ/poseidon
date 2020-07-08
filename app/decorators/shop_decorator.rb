class ShopDecorator < ResourceDecorator

  class << self
    def column_names
      %w(building level number category sub_category type agreements leases workflow edit split)
    end

    def form_element_names
      super  - %w(agreements leases split workflow) | %w(feature remark type bay depth max_height min_height bearing area temporary)
    end

    def summary_names
      [%w(building number)]
    end
  end

  def category
    resource.sub_category.try(:category)
  end

  def agreements
    h.link_to resource.agreements.size.to_s, [resource,:agreements].flatten
  end

  def leases
    h.link_to resource.active_lease ? resource.active_lease : resource.leases.size.to_s, [resource,:leases].flatten
  end

  def split
    resource.children.present? ? h.link_to(h.split_icon, h.split_shop_path(resource.id), method: :patch, remote: false) : ''
  end

end
