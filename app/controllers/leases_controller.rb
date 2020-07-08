class LeasesController < ResourcesController
  include Transitions
  include Stateful

  load_and_authorize_resource

  def show
    redirect_to [resource, :visitations]
  end

  def approve
    if resource.workflow.nil? || resource.do_approve(current_user)
      record_event(:approve)
    else
      redirect_after_event
    end
  end

  def after_approve
    resource.pending_agreements.each {|a| a.close; a.save}
  end

  protected
  def build_resource *args
    super.tap do |s|
      s.agreement ||= agreement
      s.responsible_person = current_user
      s.copy_from_agreement if outer
      s.start_date ||= Time.now.to_date
    end
  end

  def permitted_params
    super + %w(agreement_id)
  end

  def nest_content
    outer.is_a?(Agreement) ? resource_class.all : super
  end
end
