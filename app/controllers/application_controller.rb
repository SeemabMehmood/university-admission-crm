class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  layout :pick_layout

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, alert: exception.message }
    end
  end

  private

  def pick_layout
    current_user ? "application" : "devise_layout"
  end
end
