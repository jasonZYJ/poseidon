module ResourceButtonsHelper

  def action_buttons
    link_to(t(:new), new_resource_path, remote: true, class: 'btn btn-success btn-lg active', role: 'button')
  end

  def export_button
    link_to(t(:export), send("export_#{resource_class.name.tableize}_path"), class: 'btn btn-success btn-lg active', role: 'button')
  end

end
