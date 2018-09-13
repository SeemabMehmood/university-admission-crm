module RepresentingCountriesHelper
  def country_filter_options
    return ApplicationHelper::COUNTRIES if current_user.admin?
    countries = current_user.representing_countries.active if current_user.agent?
    countries = current_user.agent.representing_countries.active if current_user.branch_officer?
    countries = current_user.branch_officer.agent.representing_countries.active if current_user.counsellor?
    countries.pluck(:name).map(&:titleize)
  end

  def email_template_link(application_process)
    return edit_email_template_path(application_process.email_template) if application_process.email_template.present?
    new_email_template_path(application_process_id: application_process.id)
  end

  def form_serial_no(form_object, representing_country)
    form_object.serial.present? || representing_country.persisted? ? form_object.serial : 1
  end
end
