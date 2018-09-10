class RepresentingCountriesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_representing_country, only: [:show, :edit, :update, :change_status]
  before_action :set_redirect_url, only: [:update]

  def index
    begin
      @filterrific = initialize_filterrific(
        RepresentingCountry,
        params[:filterrific],
        select_options: {
          sorted_by: RepresentingCountry.options_for_sorted_by
        },
        persistence_id: true,
        sanitize_params: true
      ) or return

      @representing_countries = for_user().filterrific_find(@filterrific)

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
    @representing_country = RepresentingCountry.new
    @representing_country.application_processes.build
  end

  def edit
    @representing_country.application_processes.build unless @representing_country.application_processes.any?
  end

  def create
    @representing_country = RepresentingCountry.new(representing_country_params.except(:action_name))

    respond_to do |format|
      if @representing_country.save
        format.html { redirect_to representing_countries_path, notice: 'Representing country was successfully created.' }
        format.json { render :show, status: :created, location: @representing_country }
      else
        format.html { render :new }
        format.json { render json: @representing_country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @representing_country.update(representing_country_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: "Representing country was successfully updated." }
        format.json { render :show, status: :ok, location: @representing_country }
      else
        format.html { render :edit }
        format.json { render json: @representing_country.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    @representing_country.active? ? @representing_country.inactive! : @representing_country.active!
    @toggle = @representing_country.active? ? "off" : "on"
    @message = "Status successfully changed to #{@representing_country.status}"
  end

  def get_agent_representing_countries
    @agent = User.find params[:agent_id]
    @countries = params[:institution_form] ? @agent.representing_countries.active.pluck(:name, :id) : @agent.representing_countries.active.pluck(:name)
    render layout: false
  end

  private
    def set_representing_country
      id = params[:id] || params[:representing_country_id]
      @representing_country = RepresentingCountry.find(id)
    end

    def representing_country_params
      params.require(:representing_country).permit(:name, :agent_id, :action_name, application_processes_attributes: [:id, :name, :serial])
    end

    def for_user
      return RepresentingCountry.all if current_user.admin?
      return RepresentingCountry.for_agent(current_user.id) if current_user.agent?
      return RepresentingCountry.for_agent(current_user.agent.id) if current_user.branch_officer?
      return RepresentingCountry.for_agent(current_user.branch_officer.agent.id) if current_user.counsellor?
    end

    def set_redirect_url
      @redirect_url = representing_country_params[:action_name] == "show" ? @representing_country : representing_countries_path
    end
end
