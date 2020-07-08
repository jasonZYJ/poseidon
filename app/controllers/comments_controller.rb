class CommentsController < ResourcesController

  protected

  def permitted_params
    super | %w(contact_id)
  end
end
