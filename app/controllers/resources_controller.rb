class ResourcesController < ApplicationController
  include SuperResources::Controller
  include Responding
  include RedirectsForDetailRecord

  around_filter :transactions_filter, :only => %w(create update)

  helper_method :collection_fields, :decorator_context, :decorator_class, :column_names, :summary_names, :tab_names,
                :agreement

  def index
    respond_to do |format|
      format.html
      format.json { render json: collection.decorate.map { |a| {:value => a.id, :text => a.to_s} } }
    end
  end

  def show
    resource.try(:items) ? (redirect_to [resource, :items]) : super
  end

  def autocomplete
    respond_with collection.decorate.map { |a| {:id => a.id, :text => a.to_s} }
  end

  def agreement
    Agreement.find_by(id: params[:agreement_id])
  end

  protected

  def transactions_filter
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def resource_params
    params.require(resource_params_name) \
      .permit(permitted_params)
  end

  def collection_fields
    (params[:cf] & decorator_class.try(:column_names)) || []
  end

  def decorator_context
    nil
  end

  def decorator_class
    "#{resource_class}Decorator".safe_constantize
  end

  def column_names
    decorator_class.column_names
  rescue NoMethodError => e
    []
  end

  def permitted_params
    decorator_class.form_element_names
  end

  def summary_names(model=resource)
    model.class.decorator_class.summary_names
  rescue NoMethodError => e
    []
  end

  def tab_names(model=resource)
    model.class.decorator_class.tab_names
  rescue NoMethodError => e
    []
  end

  def datatable_class
    "#{resource_class}Datatable".safe_constantize
  end

  def build_resource(*args)
    memoize_resource do
      super.tap do |s|
        s.creator ||= current_user if s.respond_to?(:creator)
        s.organisation ||= current_organisation if s.respond_to?(:organisation)
      end
    end
  end

  def collection
    memoize_collection do
      super.tap do |s|
        s.merge!(resource_class.where(orgaisation: current_organisation)) if resource_class.respond_to?(:organisation)
        s.merge!(resource_class.ransack(params[:q]).result) if params[:q].present?
      end
    end
  end
end