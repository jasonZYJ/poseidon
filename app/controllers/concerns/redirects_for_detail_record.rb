module RedirectsForDetailRecord
  extend ActiveSupport::Concern

  def create
    super :location => location_after_change_action
  end

  def update
    super :location => location_after_change_action
  end

  def destroy
    super :location => location_after_change_action
  end

  protected

  def location_after_change_action
    with_nesting(controller_name)
  end
end