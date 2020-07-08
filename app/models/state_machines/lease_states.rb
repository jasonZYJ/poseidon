module LeaseStates
  extend ActiveSupport::Concern
  include StateMachine

  included do

    start_machine

  end

  module ClassMethods
    def states_to_events
      {
          open: [:submit, :cancel],
          awaiting_approval: [:approve, :cancel, :decline],
          approved: [:cancel],
          declined: [:submit, :cancel],
          cancelled: nil
      }
    end

    def events_to_states
      {
          submit: :awaiting_approval,
          approve: :approved,
          decline: :declined,
          cancel: :cancelled,
          reopen: :open
      }
    end
  end

end