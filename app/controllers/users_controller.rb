class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_user, except: [:index, :new]

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

  private

  def set_user
    id = params[:id] || params[:user_id]
    @user = User.find(id)
  end

  def user_params
    params.require(:user).permit(:type, :name, :email, :phone_num,
                                :country, :zipcode, :state,
                                :street, :city, :website, :facebook,
                                :google, :linkdIn, :twitter,
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
end
