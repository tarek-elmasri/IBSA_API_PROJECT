class Api::V1::GeneralManagersController < ApplicationController
  before_action :Authenticate_user
  before_action :Classify_user
  before_action :Authorize_user

  def approval_list
    pars= Par.where(charged_person: @current_user.id)
    render json: {pars: pars},status: :ok
  end


  private
  def Authorize_user 
    render json: {errors: ['un Authorized User']},status: :unauthorized unless @current_user.role=='GM'
  end
  
end
