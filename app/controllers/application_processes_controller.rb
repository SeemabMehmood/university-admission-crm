class ApplicationProcessesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_application_process, only: [:change_status]

  def change_status
    @application_process.active? ? @application_process.inactive! : @application_process.active!
    @toggle = @application_process.active? ? "off" : "on"
    @message = "Status successfully changed to #{@application_process.status}"
  end

  private
    def set_application_process
      id = params[:id] || params[:application_process_id]
      @application_process = ApplicationProcess.find(id)
    end
end
