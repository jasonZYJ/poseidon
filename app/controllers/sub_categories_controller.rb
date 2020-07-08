class SubCategoriesController < ResourcesController

  protected

  def build_resource(*args)
    memoize_resource do
      super.tap do |s|
        s.category ||= outer
      end
    end
  end

  def collection
    memoize_collection do
      r = super
      r = r.where(category_id: params[:parent_id]) if params[:parent_id].present?
      r
    end
  end
end