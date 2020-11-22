class Api::V1::SessionsController < ApplicationController

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


  private
  def sessions_params
    params.permit(:email , :password )
  end

end
