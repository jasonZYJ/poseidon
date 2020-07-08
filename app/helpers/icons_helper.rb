module IconsHelper

  def icon(icon_type)
    content_tag(:i, nil, :class => "menu-icon fa fa-#{icon_type.to_s.dasherize}")
  end

  def new_icon(klass=resource_class, *args)
    begin
      send "#{klass.underscore}_icon", *args
    rescue NameError
      plus_sign *args
    end
  end

  def resource_icon(resource, *args)
    send "#{resource.class.name.underscore}_icon", *args

  rescue NameError
    icon :flag, *args
  end

  def title_icon(*args)
    icon :child, *args
  end

  def email_icon(*args)
    icon :envelope_o, *args
  end

  def telephone_icon(*args)
    icon :phone, *args
  end

  def full_name_icon(*args)
    icon :child, *args
  end

  def position_icon(*args)
    icon :institution, *args
  end

  def globe_icon(*args)
    icon :globe, *args
  end

  def activity_icon(*args)
    icon :paw, *args
  end

  def preview_icon(*args)
    icon :eye, *args
  end

  def help_icon(*args)
    icon :question, *args
  end

  def sign_in_icon(*args)
    icon :sign_in, *args
  end

  def sign_out_icon(*args)
    icon :sign_out, *args
  end

  def search_icon(*args)
    icon :search, *args
  end

  def update_icon(*args)
    icon :save, *args
  end

  def sort_icon(*args)
    icon :sort, *args
  end

  def comment_icon(*args)
    icon :comment_o, *args
  end

  def comments_icon(*args)
    icon :comments_o, *args
  end

  def user_icon(*args)
    icon :user, *args
  end

  def organization_icon(*args)
    icon :group, *args
  end

  def trash_icon(*args)
    icon :trash_o, *args
  end

  def plus_sign(*args)
    icon :plus, *args
  end

  def details_icon(*args)
    icon :th, *args
  end

  def look_icon(*args)
    icon :eye, *args
  end

  def edit_icon(*args)
    icon :edit, *args
  end

  def done_icon(*args)
    icon :check, *args
  end

  def import_icon(*args)
    icon :upload, *args
  end

  def export_icon(*args)
    icon :download, *args
  end

  def pdf_icon(*args)
    icon 'file-pdf-o', *args
  end

  def print_icon(*args)
    icon :print, *args
  end

  def true_icon(*args)
    icon :check, *args
  end

  def false_icon(*args)
    icon :times, *args
  end

  def _icon(*args)
    icon :minus, *args
  end

  def back_icon(*args)
    icon :arrow_left, *args
  end

  def first_icon(*args)
    icon :fast_backward, *args
  end

  def previous_icon(*args)
    icon :step_backward, *args
  end

  def next_icon(*args)
    icon :step_forward, *args
  end

  def last_icon(*args)
    icon :fast_forward, *args
  end

  def select_icon(*args)
    icon :move, *args
  end

  def text_icon(*args)
    icon :font, *args
  end

  def erase_icon(*args)
    icon :undo, *args
  end

  def signin_icon(*args)
    icon :sign_in, *args
  end

  def chevron_right_icon(*args)
    icon :chevron_right, *args
  end

  def calender_icon(*args)
    icon :calendar, *args
  end

  def check_icon(*args)
    icon :check, *args
  end

  def diagnose_icon(*args)
    icon :stethoscope, *args
  end

  def repair_icon(*args)
    icon :medkit, *args
  end

  def impersonate_icon(*args)
    icon :certificate, *args
  end

  def attachment_icon(*args)
    icon :paperclip, *args
  end

  def copy_icon(*args)
    icon :copy, *args
  end

  def attention_icon(*args)
    icon :exclamation_triangle, *args
  end

  def investment_icon(*args)
    icon :money, *args
  end

  def private_icon(*args)
    icon :eye_slash, *args
  end

  def submit_icon *args
    icon :inbox, *args
  end

  def approve_icon *args
    icon :thumbs_o_up, *args
  end

  def decline_icon *args
    icon :thumbs_o_down, *args
  end

  def cancel_icon(*args)
    icon :thumbs_o_down, *args
  end

  def reopen_icon(*args)
    icon :thumbs_o_up, *args
  end

  def split_icon(*args)
    icon :columns, *args
  end
end
