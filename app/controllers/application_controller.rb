class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :default_variables

  def after_sign_in_path_for(_resource)
    root_path
  end

  def default_variables
    h = {
      name: "Rommel",
      age: "30",
      job: "Software Engineer",
      country: "Philippines",
      course: "MAS",
    }
    session[:watched] = []
    session[:watched].push(h)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name type])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name])
  end
end
