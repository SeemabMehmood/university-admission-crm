class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  def create
    if current_user.admin?
      @countries = ApplicationHelper::COUNTRIES
    elsif current_user.agent?
      @countries = current_user.representing_countries.active.pluck(:name)
    else
      @countries = [current_user.country]
    end
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
                                  :google, :linkdIn, :twitter, :logo, :download_csv,
                                  :contact_person_name, :contact_person_email,
                                  :contact_person_phone, :contact_person_mobile,
                                  :contact_person_skype, :contact_person_designation,
                                  :agent_id, :branch_officer_id)
    end

    def initialize_user(params)
      type = params[:type]

      case type
      when "Admin"
        User.new(params.except(:type))
      when "Agent"
        Agent.new(params.except(:type))
      when "BranchOfficer", "Branch Officer"
        BranchOfficer.new(params.except(:type))
      when "Counsellor"
        Counsellor.new(params.except(:type))
      end
    end
end
