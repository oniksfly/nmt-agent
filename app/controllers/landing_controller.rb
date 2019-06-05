class LandingController < ApplicationController
  def index
    @account_service = RemoteAccountService.call

    redirect_to :settings_setup_index unless @account_service.initialized?
  end
end
