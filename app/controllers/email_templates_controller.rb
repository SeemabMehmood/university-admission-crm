class EmailTemplatesController < ApplicationController

  def new
    @email_template = EmailTemplate.new(application_process_id: params[:application_process_id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
