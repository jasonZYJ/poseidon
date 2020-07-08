class ContactsController < ResourcesController

  protected
  def permitted_params
    super | %w(organisation_id)
  end
end
