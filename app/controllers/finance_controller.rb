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
      else
        format.html { render "finance/edit_income" }
        format.js { render "finance/edit_income.js.erb" }
      end
    end
  end

  def expense
    begin
      @filterrific = initialize_filterrific(
        Expense,
        params[:filterrific],
        select_options: {},
        persistence_id: true,
        sanitize_params: true
      ) or return

      @expenses = Expense.for_agent(current_user.id)
      if @expenses.any?
        @expenses = @expenses.filterrific_find(@filterrific)
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

  def new_expense
    @expense = current_user.expenses.new
  end

  def create_expense
    @expense = Expense.new expense_params
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to finance_expense_path, notice: "Expense was successfully updated." }
      else
        format.html { render "finance/new_expense" }
        format.js { render "finance/new_expense.js.erb" }
      end
    end
  end

  def edit_expense
    @expense = Expense.find params[:expense_id]
  end

  def update_expense
    @expense = Expense.find params[:expense_id]
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to finance_expense_path, notice: "Expense was successfully updated." }
      else
        format.html { render "finance/edit_expense" }
        format.js { render "finance/edit_expense.js.erb" }
      end
    end
  end

  private

  def income_params
    params.require(:income).permit(:date, :total_amount, :remaining_balance, :application_id)
  end

  def expense_params
    params.require(:expense).permit(:date, :paid, :reason, :agent_id)
  end
end
