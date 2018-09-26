class ReportsController < ApplicationController
  def branch_offices
    @representing_countries = current_user.representing_countries
    @branch_offices_count = current_user.branch_officers.count
  end

  def counsellors
    if current_user.agent?
      @representing_countries = current_user.representing_countries
      @branch_offices_count = current_user.branch_officers.count
    else
      @representing_countries = current_user.agent.representing_countries
      @branch_offices_count = current_user.agent.branch_officers.count
    end
  end
end
