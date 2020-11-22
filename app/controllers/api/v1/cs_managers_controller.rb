class Api::V1::CsManagersController < ApplicationController
  before_action :Authenticate_user
  before_action :Classify_user
  before_action :Authorize_user

  def create_par
    par= Par.new(cs_params)
    par.status='pending'
    par.employer_id = @classified_user.employer_id
    manager= GeneralManager.find_by(id: @classified_user.general_manager_id)
    par.charged_person = manager.employer_id

    if par.save
      render json: {par: par},status: :created
    else
      render json: {errors: par.errors},status: :unprocessable_entity
    end
  end


  def my_pars
    pars=Par.where(employer_id: @classified_user.employer_id)
    render json: {pars: pars},status: :ok
  end

  def approval_list
    pars= Par.where(charged_person: @current_user.id)
    render json: {pars: pars},status: :ok
  end

  
  private
  def cs_params
    params.permit(:par_type , :description , :value , :client_id , :client_name)
  end

  
  private
  def Authorize_user 
    render json: {errors: ['un Authorized User']},status: :unauthorized unless @current_user.role=='CSM'
  end
end
