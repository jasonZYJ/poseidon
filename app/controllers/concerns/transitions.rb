module Transitions
  extend ActiveSupport::Concern

  included do
    resource_class.events.each do |e|
      define_method(e) do
        record_event(e)
      end
    end
  end

  protected

  def record_event(event_name)
    resource.send(event_name)

    yield if block_given?

    resource.save!

    try("after_#{event_name}")

    gflash :notice => {:value => "#{event_name} SUCCESSFULLY!", :class_name => 'notice'}

  rescue StateMachine::CannotTransition => e
    gflash error: {value: e.to_s, class_name: 'error'}
    raise ::ActiveRecord::Rollback
  rescue ActiveRecord::RecordInvalid
    gflash error: {value: resource.errors.full_messages.to_sentence, class_name: 'error'}
    raise ::ActiveRecord::Rollback
  ensure
    redirect_after_event
  end

  def redirect_after_event
    respond_with resource
  end
end
