class SessionsController < Devise::SessionsController
  def create
    super do |resource|
       unless resource.active?
        sign_out
        redirect_to new_user_session_path, alert: resource.inactive_message
        return
      end
    end
  end
end
