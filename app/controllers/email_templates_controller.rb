class EmailTemplatesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_email_template, except: [:new, :create]

  def new
    @email_template = EmailTemplate.new(application_process_id: params[:application_process_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @email_template = EmailTemplate.new(email_template_params.except(:representing_country_id))

    respond_to do |format|
      if @email_template.save
        format.html { redirect_to representing_country_path(@email_template.application_process.representing_country.id), notice: 'Email Template was successfully created.' }
        format.json { render :show, status: :created, location: @email_template }
      else
        format.html { render :new }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private
    def set_email_template
      id = params[:id] || params[:email_template_id]
      @email_template = EmailTemplate.find(id)
    end

    def email_template_params
      params.require(:email_template).permit(:subject, :content, :application_process_id)
    end
end
