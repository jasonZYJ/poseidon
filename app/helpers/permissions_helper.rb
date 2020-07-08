module PermissionsHelper

  def available_resources
    Poseidon::ActiveRecord.restricted_resources.map{|c| [human(c) , c.resource_type ]}
  end
end