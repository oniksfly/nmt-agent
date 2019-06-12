class Settings::ClientsController < ApplicationController
  def index
    @clients = Torrents::Client.all
  end

  def new
    @client = Torrents::Client.new
  end

  def create
    @client = Torrents::Client.new(client_params)
    if @client.save
      redirect_to settings_clients_url
    else
      render :new
    end
  end

  def edit
    @client = Torrents::Client.find(params[:id])
  end

  def update
    @client = Torrents::Client.find(params[:id])
    if @client.update(client_params)
      redirect_to settings_clients_url
    else
      render :edit
    end
  end

  def destroy
    Torrents::Client.find(params[:id]).destroy

    redirect_to settings_clients_url
  end
  
  private
  def client_params
    params.require(:client).permit(:type, :host, :port, :path, :username, :password)
  end
end