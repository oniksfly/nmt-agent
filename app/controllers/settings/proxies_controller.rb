class Settings::ProxiesController < ApplicationController
  def index
    @proxies = Proxy.all.order(created_at: :desc)
  end

  def new
    @proxy = Proxy.new
  end

  def create
    @proxy = Proxy.new(proxy_params)

    if @proxy.save
      redirect_to settings_proxies_url
    else
      render :new
    end
  end

  def edit
    @proxy = Proxy.find(params[:id])
  end

  def update
    @proxy = Proxy.find(params[:id])

    if @proxy.update(proxy_params)
      redirect_to settings_proxies_url
    else
      render :edit
    end
  end

  def destroy
    Proxy.find(params[:id]).destroy

    redirect_to settings_proxies_url
  end

  def test
    @proxy = Proxy.find(params[:id])
    @result = @proxy.test_connection

    render :edit
  end

  private 
  def proxy_params
    params.require(:proxy).permit(:kind, :server_host, :server_port, :username, :password)
  end
end