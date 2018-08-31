module ApplicationHelper
  def accessible_role_name
    return "Agents"          if current_user.admin?
    return "Branch Officers" if current_user.agent?
    "Counsellors"            if current_user.branch_officer?
  end

  def accessible_subordinate_name
    return "BO's"          if current_user.admin?
    return "Counsellors"   if current_user.agent?
    "Applications"         if current_user.branch_officer?
  end

  def no_data_message(collection_object)
    ["<b>No ", titleize(model_name(collection_object.table_name)), " found.</b>"].join.html_safe unless collection_object.any?
  end

  def format_datetime(raw_date)
    return "--" unless raw_date
    raw_date.strftime("%d-%m-%Y at %l:%M%p")
  end
end
