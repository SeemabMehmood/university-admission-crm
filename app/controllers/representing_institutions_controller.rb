class RepresentingInstitutionsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_representing_institution, only: [:show, :edit, :update, :change_status]
  before_action :set_redirect_url, only: [:update]
  before_action :set_representing_countries, only: [:new, :create, :edit, :update]

  def index
    begin
      @filterrific = initialize_filterrific(
        RepresentingInstitution,
        params[:filterrific],
        select_options: {
          sorted_by: RepresentingInstitution.options_for_sorted_by
        },
        persistence_id: true,
        sanitize_params: true
      ) or return

      @institution_names = for_user().pluck(:name)
      @campuses = for_user().pluck(:campus)

      @representing_institutions = for_user().filterrific_find(@filterrific)

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
  end

  def create
    @representing_institution = RepresentingInstitution.new(representing_institution_params.except(:action_name))

    respond_to do |format|
      if @representing_institution.save
        format.html { redirect_to representing_institutions_path, notice: 'Representing Institution was successfully created.' }
        format.json { render :show, status: :created, location: @representing_institution }
      else
        format.html { render :new }
        format.json { render json: @representing_institution.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @representing_institution.update(representing_institution_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: "Representing Institution was successfully updated." }
        format.json { render :show, status: :ok, location: @representing_institution }
      else
        format.html { render :edit }
        format.json { render json: @representing_institution.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    @representing_institution.active? ? @representing_institution.inactive! : @representing_institution.active!
    @toggle = @representing_institution.active? ? "off" : "on"
    @message = "Status successfully changed to #{@representing_institution.status}"
  end

  private
    def set_representing_institution
      id = params[:id] || params[:representing_institution_id]
      @representing_institution = RepresentingInstitution.find(id)
    end

    def representing_institution_params
      params.require(:representing_institution).permit(:name, :campus, :contact_person, :email, :contact, :website, :logo,
                                                        :representing_country_id, :user_id, :action_name)
    end

    def set_redirect_url
      @redirect_url = representing_institution_params[:action_name] == "show" ? @representing_institution : representing_institutions_path
    end

    def for_user
      return RepresentingInstitution.all if current_user.admin?
      return RepresentingInstitution.for_agent(current_user.id) if current_user.agent?
      return RepresentingInstitution.for_agent(current_user.agent.id) if current_user.branch_officer?
      return RepresentingInstitution.for_agent(current_user.branch_officer.agent.id) if current_user.counsellor?
    end

    def set_representing_countries
      if current_user.admin?
        @representing_countries = @representing_institution.new_record? ? [] : @representing_institution.agent.representing_countries.active.pluck(:name, :id)
      else
        @representing_countries = current_user.agent? ?  current_user.representing_countries.active.pluck(:name, :id) : current_user.agent.representing_countries.active.pluck(:name, :id)
      end
    end
end
