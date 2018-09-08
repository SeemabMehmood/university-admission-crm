module UsersHelper
  def show_users_count(count)
    return "Users: #{count}"           if current_user.admin?
    return "Branch Officers: #{count}" if current_user.agent?
    "Counsellors: #{count}"            if current_user.branch_officer?
  end

  def error_form_url(user)
    h = { html: { novalidate: true } }
    if user.new_record? && user.errors.any?
      h[:url] = { controller: "registrations", action: "create" }
      h[:method] = :post
    end
    h
  end

  def roles_map
    User::ROLES.map { |r| [r.titleize, r == "admin" ? "Admin" : r == "branch_officer" ? "BranchOfficer" : r.titleize] }
  end

  def show_superior_name(user)
    return if user.agent? || user.admin?
    sup_name =  ["| Corresponding Agent: ", link_to(user.agent.name.titleize, user_path(user.agent_id))].join() if user.branch_officer?
    sup_name = ["| Corresponding Branch Officer: ", link_to(user.branch_officer.name.titleize, user_path(user.branch_officer_id))].join() if user.counsellor?
    sup_name.html_safe
  end

  def back_user_form_url(action_name, user)
    return users_path if action_name == 'index' || user.new_record?
    user if action_name == 'show' || action_name.blank?
  end

  def user_form_submit_text(form_object)
    [form_object.new_record? ? "Add" : "Update", form_object.role.titleize].join(" ")
  end
end
