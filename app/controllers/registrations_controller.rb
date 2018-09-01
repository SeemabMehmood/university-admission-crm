class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  def create
    @user = initialize_user(sign_up_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "#{@user.role.titleize} was successfully created." }
        format.json { render :index }
      else
        format.html { render new_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:type, :name, :email, :phone_num,
                                  :country, :zipcode, :state, :skypeId,
                                  :street, :city, :website, :facebook,
                                  :google, :linkdIn, :twitter)
    end

    def initialize_user(params)
      type = params[:type]

      case type
      when "admin"
        User.new(params.except(:type))
      when "agent"
        Agent.new(params.except(:type))
      when "branch_officer"
        BranchOfficer.new(params.except(:type))
      when "counsellor"
        Counsellor.new(params.except(:type))
      end
    end
end
