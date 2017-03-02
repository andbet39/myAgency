class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
