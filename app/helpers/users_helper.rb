module UsersHelper
  def show_users_count
    return "Agents: #{@agents_count}"         if current_user.admin?
    return "Branch Officers: #{@users_count}" if current_user.agent?
    "Counsellors: #{@users_count}"            if current_user.branch_officer?
  end
end
