module RepresentingCountriesHelper
  def back_representing_country_form_url(action_name, country)
    return representing_countries_path if action_name == 'index' || country.new_record?
    country if action_name == 'show' || action_name.blank?
  end

  def country_filter_options
    return ApplicationHelper::COUNTRIES if current_user.admin?
    countries = current_user.representing_countries if current_user.agent?
    countries = current_user.agent.representing_countries if current_user.branch_officer?
    countries = current_user.branch_officer.agent.representing_countries if current_user.counsellor?
    countries.pluck(:name).map(&:titleize)
  end

  def email_template_link(application_process)
    return edit_email_template_path(application_process.email_template) if application_process.email_template.present?
    new_email_template_path(application_process_id: application_process.id)
  end
end
