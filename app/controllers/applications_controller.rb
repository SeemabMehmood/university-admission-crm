class ApplicationsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  before_action :check_if_representing_institutions_assigned
  before_action :set_application, only: [:show, :edit, :update]
  before_action :set_redirect_url, only: [:update]
  before_action :set_form_data, only: [:new, :create, :edit, :update]

  def index
    begin
      @filterrific = initialize_filterrific(
        Application,
        params[:filterrific],
        select_options: {
          sorted_by: Application.options_for_sorted_by
        },
        persistence_id: true,
        sanitize_params: true
      ) or return

      @applications = @filterrific.find()

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
    @application = Application.new
    @application.build_applicant.educations.build
  end

  def create
    @application = Application.new(application_params.except(:action_name))
    respond_to do |format|
      if @application.save
        format.html { redirect_to applications_path, notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        @application.build_applicant
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @application.update(application_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_application
      id = params[:id] || params[:application_id]
      @application = Application.find(id)
    end

    def application_params
      params.require(:application).permit(:counsellor_id, :representing_country_id,
                                          :course_name, :intake_year, :intake_month,
                                          :action_name, :representing_institution_id, :additional_document,
                                          applicant_attributes: [:id, :first_name, :last_name, :gender,
                                            :title, :marital_status, :dob, :nationality,
                                            :passport, :passport_no, :phone_cc, :phone_code,
                                            :phone_num, :mobile_cc, :mobile_code,
                                            :mobile_num, :email, :skypeid,
                                            educations_attributes: [:id, :qualification, :institute,
                                              :year_passing, :grade, :scanned_doc]] )
    end

    def set_redirect_url
      @redirect_url = application_params[:action_name] == "show" ? @application : applications_path
    end

    def check_if_representing_institutions_assigned
      redirect_to root_path, alert: "You have no assigned Representing Institution." unless current_user.representing_institutions.present?
    end

    def set_form_data
      @representing_countries = current_user.branch_officer.representing_countries.pluck(:name, :id)
      @representing_institutions = current_user.representing_institutions.pluck(:name, :id)
    end
end
