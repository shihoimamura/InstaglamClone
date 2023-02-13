class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  
  unless Rails.env.development?
    rescue_from Exception,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end
 
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end
 
  private
 
  def render_404
    render 'error/404', status: :not_found
  end
 
  def render_500
    render 'error/500', status: :internal_server_error
  end
  
  private

  def login_required
    redirect_to new_session_path unless current_user
  end
end
