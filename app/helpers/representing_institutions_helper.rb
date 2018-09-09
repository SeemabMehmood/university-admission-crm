module RepresentingInstitutionsHelper
  def back_representing_institution_form_url(action_name, institution)
    return representing_institutions_path if action_name == 'index' || institution.new_record?
    institution if action_name == 'show' || action_name.blank?
  end
end
