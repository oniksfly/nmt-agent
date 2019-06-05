class Settings::SetupController < ApplicationController

  def index
    @account_service = RemoteAccountService.call

    redirect_to :root if @account_service.initialized?
  end

  def create
    @account_service = RemoteAccountService.call

    if @account_service.update_and_validate(server_token: settings_params[:server_token])
      @account_service.register_server_token
      redirect_to :root
    else
      render :index
    end
  end

  private
  def settings_params
    params.require(:settings).permit(:server_token)
  end
end