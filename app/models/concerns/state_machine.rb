module StateMachine
  extend ActiveSupport::Concern

  class CannotTransition < StandardError
    def initialize(event, next_events, state, message=nil)
      @message = message
      @event = event
      @next_events = next_events
      @state = state
      @default_message = I18n.t(:cannot_transition, event: event.to_s.titleize, state: state.titleize)
    end

    def to_s
      @message || @default_message
    end
  end

  module ClassMethods
    def states
      states_to_events.keys
    end

    def events
      events_to_states.keys
    end

    def state_questions
      states.map { |s| "#{s}?" }
    end

    def state_after(event)
      [events_to_states[event.to_sym]].flatten.first.to_s
    end

    def start_machine
      states.each do |s|
        scope s, -> { where(:state => s) }

        module_eval <<-RUBY_EVAL
          def #{s}?
            state == '#{s.to_s}'
          end
        RUBY_EVAL
      end

      events.each do |e|
        module_eval <<-RUBY_EVAL
          def #{e}
            process_event('#{e}')
          end

          def record_#{e}!
            send('#{e}')
            save!
          end
        RUBY_EVAL
      end
    end
  end

  def initialize(*args)
    super
    self.state ||= self.class.states.first.to_s
  end

  def next_events
    [self.class.states_to_events[state.to_sym]].flatten.compact
  end

  def general_class
    self.class
  end

  def process_event(event)
    raise CannotTransition.new(event.to_sym, next_events, state) unless can_process_event?(event)
    self.state = self.class.state_after(event)
  end

  def can_process_event?(event)
    next_events.include?(event.to_sym)
  end
end

