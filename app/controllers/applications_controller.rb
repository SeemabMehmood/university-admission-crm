class ApplicationsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  before_action :check_if_representing_institutions_assigned
  before_action :set_application, only: [:show, :edit, :update, :edit_status,
                                        :update_status, :track_history,
                                        :admin_notes, :create_admin_notes,
                                        :forward, :forward_application,
                                        :reminder_email, :send_reminder_email]

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
    @application.build_applicant_data
  end

  def create
    @application = Application.new(application_params.except(:action_name))
    respond_to do |format|
      if @application.save
        format.html { redirect_to applications_path, notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
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

  def edit_status
    @application_history = @application.application_histories.new
  end

  def update_status
    @application_history = @application.application_histories.new(application_history_params)
    respond_to do |format|
      if @application_history.save
        format.html { redirect_to application_path(@application.id), notice: 'Status was successfully updated.' }
      else
        format.html { render "applications/edit_status" }
        format.js { render "applications/edit_status.js.erb" }
      end
    end
  end

  def track_history
    @application_histories = @application.application_histories.order(:created_at)
    @admin_notes = @application.admin_notes.order(:created_at)
    @forwards = @application.forwards.order(:created_at)
    @reminders = @application.reminders.order(:created_at)
  end

  def admin_notes
    @admin_note = @application.admin_notes.new
  end

  def create_admin_notes
    @admin_note = @application.admin_notes.new(admin_notes_params)
    respond_to do |format|
      if @admin_note.save
        format.html { redirect_to application_path(@application.id), notice: 'Admin note was successfully created.' }
      else
        format.html { render "applications/admin_notes" }
        format.js { render "applications/admin_notes.js.erb" }
      end
    end
  end

  def forward
    @forward = @application.forwards.new
  end

  def forward_application
    @forward = @application.forwards.new(forward_params)
    respond_to do |format|
      if @forward.save
        format.html { redirect_to application_path(@application.id), notice: 'Application was successfully forwarded.' }
      else
        format.html { render "applications/forward" }
        format.js { render "applications/forward.js.erb" }
      end
    end
  end

  def reminder_email
    @reminder = @application.reminders.new
  end

  def send_reminder_email
    @reminder = @application.reminders.new(reminder_params)
    respond_to do |format|
      if @reminder.save
        ApplicantMailer.reminder(@reminder.sender_name, @reminder.sender_email,
                              @reminder.reciever_name, @reminder.reciever_email,
                              @reminder.message, @reminder.attachment).deliver_now

        format.html { redirect_to application_path(@application.id), notice: 'Reminder has successfully sent.' }
      else
        format.html { render "applications/reminder_email" }
        format.js { render "applications/reminder_email.js.erb" }
      end
    end
  end

  private
    def set_application
      id = params[:id] || params[:application_id]
      @application = Application.find(id)
    end

    def application_params
      params.require(:application).permit(:counsellor_id, :representing_country_id, :interview_date,
                                          :course_name, :intake_year, :intake_month,
                                          :action_name, :representing_institution_id, :additional_document,
                                          :accommodation, :medical, :details_additional,
                                          :statement_of_purpose, :statement_of_purpose_doc,
                                          applicant_attributes: [:id, :first_name, :last_name, :gender,
                                            :title, :marital_status, :dob, :nationality,
                                            :passport, :passport_no, :phone_cc, :phone_code,
                                            :phone_num, :mobile_cc, :mobile_code,
                                            :mobile_num, :email, :skypeid,
                                            educations_attributes: [:id, :qualification, :institute,
                                              :year_passing, :grade, :scanned_doc],
                                              languages_attributes: [:id, :test_type, :reading, :writing,
                                                :scanned_doc, :listening, :speaking, :overall],
                                                work_experiences_attributes: [:id, :employer, :position, :period,
                                                  :responsibilities, :scanned_doc],
                                                  references_attributes: [:id, :name, :designation, :institution,
                                                  :fax, :address, :email, :phone, :city, :state, :country, :postal_code]] )
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

    def application_history_params
      params.require(:application_history).permit(:application_id, :status,
                                                  :note, :document)
    end

    def admin_notes_params
      params.require(:admin_note).permit(:application_id, :details)
    end

    def forward_params
      params.require(:forward).permit(:application_id, :sender_name,
                                      :sender_email, :reciever_email,
                                      :reciever_name, :message)
    end

    def reminder_params
      params.require(:reminder).permit(:application_id, :sender_name,
                                      :sender_email, :reciever_email,
                                      :reciever_name, :message, :attachment)
    end
end
