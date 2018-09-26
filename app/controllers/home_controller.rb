class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @agents = Agent.all
      @branch_officers = BranchOfficer.all
      @counsellors = Counsellor.all
      @applications = Application.all

    elsif current_user.agent?
      @representing_countries = current_user.representing_countries
      @representing_institutions = current_user.representing_institutions
      @branch_officers = current_user.branch_officers
      @counsellors = Counsellor.for_agent(current_user.id)
      @applications = Application.for_agent(current_user.id)
      @total_income = Income.for_user(current_user.id).sum('total_amount - remaining_balance').to_f
      @total_remaining = Income.for_user(current_user.id).sum(:remaining_balance).to_f
      @total_expense = Expense.for_agent(current_user.id)

    elsif current_user.branch_officer?
      @representing_countries = current_user.representing_countries
      @representing_institutions = current_user.representing_institutions
      @counsellors = current_user.counsellors
      @applications = Application.for_branch_officer(current_user.id)
      @total_income = Income.for_user(current_user.agent.id).sum('total_amount - remaining_balance').to_f
      @total_remaining = Income.for_user(current_user.agent.id).sum(:remaining_balance).to_f

    elsif current_user.counsellor?
      @representing_countries = current_user.branch_officer.representing_countries
      @representing_institutions = current_user.branch_officer.representing_institutions
      @branch_officers = current_user.agent.branch_officers
      @applications = Application.for_counsellor(current_user.id)
    end
  end
end
