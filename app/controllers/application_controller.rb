module Current
  thread_mattr_accessor :user
end
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_accessor :has_help
  around_filter :set_current_user
  def set_current_user
      Current.user = current_user
      yield
    ensure
      # to address the thread variable leak issues in Puma/Thin webserver
      Current.user = nil
    end

  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      if home_controller?
        "homepage"
      else
        "application"
      end
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    searches_path
  end


end
