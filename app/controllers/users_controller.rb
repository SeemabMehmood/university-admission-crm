class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_user, except: [:index, :new]
  before_action :set_countries, only: [:edit, :update]

  def index
    begin
      @filterrific = initialize_filterrific(
        User,
        params[:filterrific],
        select_options: {
          sorted_by: User.options_for_sorted_by
        },
        persistence_id: true,
        sanitize_params: true
      ) or return

      @users = User.get_users_for(current_user)
      if @users.any?
        @users = @users.filterrific_find(@filterrific)
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

  def new
    @user = build_users
    if current_user.admin?
      @countries = ApplicationHelper::COUNTRIES
    elsif current_user.agent?
      @countries = current_user.representing_countries.active.pluck(:name)
    else
      @countries = [current_user.country]
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params.except(:type))
        format.html { redirect_to users_path, notice: "#{@user.role.titleize} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    @user.active? ? @user.inactive! : @user.active!
    @toggle = @user.active? ? "off" : "on"
    @message = "Status successfully changed to #{@user.status}"
  end

  def agent_branch_officers
    @branch_officers = @user.branch_officers.active.pluck(:id, :name)
    render layout: false
  end

  def get_user_data
    render layout: false
  end

  private

  def set_user
    id = params[:id] || params[:user_id]
    @user = User.find(id)
  end

  def user_params
    params.require(:user).permit(:type, :name, :email, :phone_num,
                                :country, :zipcode, :state, :logo,
                                :street, :city, :website, :facebook,
                                :google, :linkdIn, :twitter, :download_csv,
                                :contact_person_name, :contact_person_email,
                                :contact_person_phone, :contact_person_mobile,
                                :contact_person_skype, :contact_person_designation,
                                :agent_id, :branch_officer_id)
  end

  def build_users
    return current_user.branch_officers.new if current_user.agent?
    return current_user.counsellors.new     if current_user.branch_officer?
    User.new                                if current_user.admin?
  end

  def set_countries
    if current_user.admin?
      @countries = @user.branch_officer? ? @user.agent.representing_countries.active.pluck(:name) : ApplicationHelper::COUNTRIES
    elsif current_user.agent?
      @countries = current_user.representing_countries.active.pluck(:name)
    else
      @countries = [current_user.country]
    end
  end
end
