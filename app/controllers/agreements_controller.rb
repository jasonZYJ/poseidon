class AgreementsController < ResourcesController
  include Stateful

  load_and_authorize_resource

  def show
    redirect_to [resource, :visitations]
  end

  protected

  def build_resource(*args)
    memoize_resource do
      super.tap do |s|
        s.shop ||= outer
        s.responsible_person ||= current_user
      end
    end
  end

  def permitted_params
    super | %w(shop_id brand_id responsible_person_id)
  end
end
