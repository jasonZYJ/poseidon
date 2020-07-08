class ShopImportsController < AttachmentsController

  def build_resource(*args)
    memoize_resource do
      super.tap do |s|
        s.organisation ||= current_organisation
      end
    end
  end

  protected
  def permitted_params
    %w(organisation_id, attachment)
  end
end
