module StateMachinesHelper
  def next_state_buttons(r, exclude=[])
    (r.next_events - exclude).map do |s|
      next_state_button(s)
    end.join(' ').html_safe
  end

  def next_state_button(state, enabled=true)
    link_to [state, nests].flatten, method: :patch, remote: false, class:"btn navbar-btn btn-warning btn-lg next-state #{state}", disabled: !enabled do
                                    self.send("#{state}_icon") << ' ' << t("activerecord.attributes.#{nest_resource_type}.#{state}", default:  state.to_s.humanize).titleize
                                  end
  end

  def nest_resource_type
    outer.model_name.to_s.underscore
  end
end
