class FollowupsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_followup, only: [:show, :edit, :update, :change_status, :destroy]
  before_action :set_redirect_url, only: [:update]
  before_action :set_form_data, only: [:edit, :update, :new, :create]

  def index
    begin
      @filterrific = initialize_filterrific(
        Followup,
        params[:filterrific],
        select_options: {
          sorted_by: Followup.options_for_sorted_by
        },
        persistence_id: false,
        sanitize_params: true
      ) or return

      @followups = for_current_user()
      if @followups.any?
        @followups = @followups.filterrific_find(@filterrific)
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

  def show
  end

  def new
    @followup = Followup.new
    @followup.build_applicant_data
  end

  def create
    @followup = Followup.new(followup_params.except(:action_name))
    respond_to do |format|
      if @followup.save
        format.html { redirect_to followups_path, notice: "Followup was successfully created." }
        format.json { render :show, status: :created, location: @followup }
      else
        format.html { render :new }
        format.json { render json: @followup.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @followup.update(followup_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: "Followup was successfully updated." }
        format.json { render :show, status: :ok, location: @followup }
      else
        format.html { render :edit }
        format.json { render json: @followup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @followup.destroy
    redirect_to followups_path
  end

  def change_status
    @followup.active? ? @followup.inactive! : @followup.active!
    @toggle = @followup.active? ? "off" : "on"
    @message = "Status successfully changed to #{@followup.status}"
  end

  private
    def set_followup
      id = params[:id] || params[:followup_id]
      @followup = Followup.find(id)
    end

    def followup_params
      params.require(:followup).permit(:date, :description, :agent_id,
                                          :representing_country_id,
                                          :action_name, :additional_document,
                                          applicant_attributes: [:id, :first_name, :last_name, :gender,
                                            :title, :marital_status, :dob, :nationality,
                                            :passport, :passport_no, :phone_cc, :phone_code,
                                            :phone_num, :mobile_cc, :mobile_code,
                                            :mobile_num, :email, :skypeid,
                                            educations_attributes: [:id, :qualification, :institute,
                                              :year_passing, :grade, :starting_year, :scanned_doc],
                                              languages_attributes: [:id, :test_type, :reading, :writing,
                                                :scanned_doc, :listening, :speaking, :overall],
                                                work_experiences_attributes: [:id, :employer, :position, :period,
                                                  :responsibilities, :scanned_doc],
                                                  references_attributes: [:id, :name, :designation, :institution,
                                                  :fax, :address, :email, :phone, :city, :state, :country, :postal_code]] )
    end

    def for_current_user
      return Followup.all if current_user.admin?
      return Followup.for_agent(current_user.id) if current_user.agent?
      return Followup.for_agent(current_user.agent.id) if current_user.branch_officer?
      return Followup.for_agent(current_user.branch_officer.agent.id) if current_user.counsellor?
    end

    def set_redirect_url
      @redirect_url = followup_params[:action_name] == "show" ? @followup : followups_path
    end

    def set_form_data
      if current_user.agent?
        @representing_countries = current_user.representing_countries.pluck(:name, :id)
      elsif current_user.branch_officer?
        @representing_countries = current_user.representing_countries.pluck(:name, :id)
      else
        @representing_countries = current_user.branch_officer.representing_countries.pluck(:name, :id)
      end
    end
end
