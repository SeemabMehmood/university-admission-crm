class FinanceController < ApplicationController
  before_action :authenticate_user!

  def income
    begin
      @filterrific = initialize_filterrific(
        Income,
        params[:filterrific],
        select_options: {},
        persistence_id: true,
        sanitize_params: true
      ) or return

      @incomes = Income.for_user(current_user.id)
      if @incomes.any?
        @incomes = @incomes.filterrific_find(@filterrific)
      end

      respond_to do |format|
        format.html
        format.js
      end
    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
    end
  end

  def edit_income
    @income = Income.find params[:income_id]
  end

  def update_income
    @income = Income.find params[:income_id]
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to finance_income_path, notice: "Income was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def income_params
    params.require(:income).permit(:date, :total_amount, :remaining_balance, :application_id)
  end
end
