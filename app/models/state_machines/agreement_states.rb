module AgreementStates
  extend ActiveSupport::Concern
  include StateMachine

  included do

    start_machine

  end

  module ClassMethods
    def states_to_events
      {
          open: [:close],
          closed: [:reopen]
      }
    end

    def events_to_states
      {
          close: :closed,
          reopen: :open
      }
    end
  end

end