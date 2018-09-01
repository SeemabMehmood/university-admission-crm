module UsersHelper
  def show_users_count(count)
    return "Users: #{count}"           if current_user.admin?
    return "Branch Officers: #{count}" if current_user.agent?
    "Counsellors: #{count}"            if current_user.branch_officer?
  end
end
