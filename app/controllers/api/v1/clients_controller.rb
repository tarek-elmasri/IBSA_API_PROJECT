class Api::V1::ClientsController < ApplicationController
  def get_client
    client = Client.find_by(client_id: params[:client_id])

    if client
      render json:{client_name: client.name},status: :ok
    else
      render json:{client_name: "N/A"},status: :ok
    end
  end


  
end