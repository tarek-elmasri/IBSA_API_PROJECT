class Api::V1::SessionsController < ApplicationController

  before_action :Authenticate_user , only: [:create_user]

  def auth_by_email_and_password
    user=Employer.new(sessions_params).auth_by_email

    if user
      render json:{user: user.data},status: :ok
    else
      render json: {errors: ['Invalid email or password']},status: :unauthorized
    end
  end

  def auth_by_token
    user=Employer.new.auth_by_token(params[:token])

    if user
      render json: {user: user.data},status: :ok
    else
      render json: {errors: ['Invalid or Expired Token']},status: :unauthorized
    end
  end
#----------------------------
  def get_managers_list
    role= params[:role]
    list=[]
    case role
    when 'MR'
      managers = AreaManager.all
    when 'DM'
      managers = MarketingManager.all
    when 'MM'
      managers = CsManager.all
    when 'CSM'
      managers = GeneralManager.all
    end

    managers&.each do |manager| 
      list.push({manager_id: manager.id,
                manager_name: Employer.find_by(id: manager.employer_id).username})
    end

    render json: {managers: list},status: :ok
  end

  def create_user
    if @current_user.role == 'GM'
      
      user=Employer.new(sessions_params).downcase_email
      related_manager_id = params[:manager_id]
      if related_manager_id && user.save
    
        case (user.role)
        when 'MR'
          user_cat= MedicalRep.new(area_manager_id: related_manager_id)
        when 'DM'
          user_cat= AreaManager.new(marketing_manager_id: related_manager_id)
        when 'MM'
          user_cat= MarketingManager.new(cs_manager_id: related_manager_id)
        when 'CSM'
          user_cat=CsManager.new(general_manager_id: related_manager_id)
        when 'GM'
          user_cat=GeneralManager.new
        end
        
        user_cat.employer_id = user.id

        if user_cat.save
          render json:{user: user.data},status: :created
        else
          user.delete
          render json:{errors: ['error creating account']},status: :unprocessable_entity
        end
        
      else
        render json: {errors: ['Error creating user']},status: :unprocessable_entity
      end
    else
      render json: {errors: ['UnAuthorized Action']},status: :unauthorized
    end
  end


  private
  def sessions_params
    params.permit(:email , :password , :password_confirmation , :username , :role )
  end

end
