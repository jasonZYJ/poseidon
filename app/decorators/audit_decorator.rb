class AuditDecorator < ResourceDecorator

  class << self
    def column_names
      %w(user action audited_changes)
    end

    def editable_blacklist
      column_names
    end
  end

  def audited_changes
    resource.audited_changes.map{|k,v| "#{resource.auditable.class.human_attribute_name(k)} : #{h.t('actions.from')}  #{v.first.to_s} #{h.t('actions.to')} #{v.last.to_s}"}.join(',') if resource.action == 'update'
  end

  def action
    h.t("actions.#{resource.action}")
  end

end
