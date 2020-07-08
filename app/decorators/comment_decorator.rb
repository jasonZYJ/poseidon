class CommentDecorator < ResourceDecorator

  class << self
    def column_names
      %w(body creator created_at delete)
    end

    def form_element_names
      %w(is_private body)
    end
  end

  def delete
    h.current_user == resource.creator ? super : ''
  end

end
