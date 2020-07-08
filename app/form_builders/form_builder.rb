class FormBuilder < ResourceFormBuilder

  # def building_site
  #   association :building_site, :collection => BuildingSite.all.order(:name),  :include_blank => false
  # end
  #
  # def building_list
  #   association :building_list, :collection => BuildingList.all.order(:name), :include_blank => false
  # end
  #
  # def real_estate_project
  #   association :real_estate_project, :collection => RealEstateProject.all.order(:location), :include_blank => false
  # end
  #
  # def project_item
  #   association :project_item, :collection => ProjectItem.where(real_estate_project: template.outer), :include_blank => false
  # end
  #
  # def installments
  #   template.render(:partial => 'installments', :locals => {:investment_plan => template.outer})
  # end

  def category
    input :category, :collection => Category.all.order(:name)
  end

  def sub_category
    association :sub_category, :collection => SubCategory.all.order(:name), :include_blank => false
  end

  def shop_type
    association :shop_type, :collection => ShopType.all.order(:name), :include_blank => false
  end

  def brand
    association :brand, :collection => Brand.all.order(:name), :include_blank => false
  end

  def contact
    association :contact, collection: Contact.all.order(:full_name)
  end

  def organisation
    association :organisation, collection: Organisation.all.order(:name)
  end

  def agreement
    association :agreement, collection: Agreement.all
  end

  def user
    association :user, collection: User.all.order(:name)
  end

  def role
    association :role, collection: Role.all.order(:name)
  end

  def shop
    association :shop, collection: Shop.all.order(:building, :number)
  end
end
