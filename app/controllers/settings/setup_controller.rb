class Settings::SetupController < ApplicationController

  def setup
    @account_service = RemoteAccountService.call

    if @account_service.initialized?
      redirect_to :root
    else

    end
  end

  def configure

  end
end