class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @agents = Agent.all
      @branch_officers = BranchOfficer.all
      @counsellors = Counsellor.all
    elsif current_user.agent?
      @branch_officers = current_user.branch_officers
      @counsellors = current_user.get_counsellors
    elsif current_user.branch_officer?
      @counsellors = current_user.counsellors
    end
  end
end
