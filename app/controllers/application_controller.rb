class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_accessor :has_help


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
end
