class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :new]

  def index
    @users = User.get_users_by_role(current_user)
  end

  def new
    @user = User.build_for_role(current_user)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
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
                                :google, :linkdIn, :twitter)
  end

end
