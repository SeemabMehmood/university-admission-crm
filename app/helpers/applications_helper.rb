module ApplicationsHelper
  def back_application_form_url(action_name, application)
    return applications_path if action_name == 'index' || application.new_record?
    application if action_name == 'show' || action_name.blank?
  end
end
