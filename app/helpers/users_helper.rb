module UsersHelper
  def show_users_count(count)
    return "Users: #{count}"           if current_user.admin?
    return "Branch Officers: #{count}" if current_user.agent?
    "Counsellors: #{count}"            if current_user.branch_officer?
  end

  def error_form_url(user)
    h = {}
    if user.new_record? && user.errors.any?
      h[:url] = { controller: "registrations", action: "create" }
      h[:method] = :post
    end
    h
  end
end
