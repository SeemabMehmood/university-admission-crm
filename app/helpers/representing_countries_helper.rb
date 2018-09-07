module RepresentingCountriesHelper
  def back_representing_country_form_url(action_name, country)
    return representing_countries_path if action_name == 'index' || country.new_record?
    country if action_name == 'show' || action_name.blank?
  end
end
