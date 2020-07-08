class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  helper_method :current_organisation

  # load_and_authorize_resource
  # check_authorization

  def current_organisation
    @current_organisation ||= current_user.try(:organisation)
  end

  #handle permission resque
  rescue_from CanCan::AccessDenied do |exception|
    gflash error: {value: "#{current_user}, #{exception.message}", class_name: 'error'}
    redirect_to root_url, :alert => exception.message
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:controller])
  end

end
