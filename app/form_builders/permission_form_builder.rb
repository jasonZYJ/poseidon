class PermissionFormBuilder < FormBuilder
  def resource_type
     input :resource_type, collection: template.available_resources, :include_blank => false
  end

  def role
    association :role, :collection => Role.all.order(:name), :include_blank => false
  end

end
