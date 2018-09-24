class ReportsController < ApplicationController
  def branch_offices
    @representing_countries = current_user.representing_countries
    @branch_offices_count = current_user.branch_officers.count
  end

  def counsellors
    @representing_countries = current_user.representing_countries
    @branch_offices_count = current_user.branch_officers.count
  end
end
