class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :pick_layout

  private

  def pick_layout
    current_user ? "application" : "devise_layout"
  end
end
