class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :create, :new]

  def index
    @users = User.get_users_by_role(current_user)
    @agents_count = User.agents.count if current_user.admin?
  end

  def new

  end

  def create

  end

  def edit

  end

  def show

  end

  def update

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

end
