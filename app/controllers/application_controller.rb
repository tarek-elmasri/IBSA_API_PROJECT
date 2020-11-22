class ApplicationController < ActionController::API

  def Authenticate_user
    token = request.headers['Authorization']
    @current_user = Employer.new.auth_by_token(token)
    render json:{errors: ['Invalid or expired token']},status: :unprocessable_entity unless @current_user.present?
  end


  def Classify_user
    case @current_user.role
    when 'MR'
      @classified_user = MedicalRep.find_by(Employer_id: @current_user.id)
      @manager_id = AreaManager.find_by(id: @classified_user.area_manager_id)&.employer_id
    when 'GM'
      @classified_user = GeneralManager.find_by(Employer_id: @current_user.id)
      @manager_id= @current_user.id
    when 'CSM'
      @classified_user = CsManager.find_by(Employer_id: @current_user.id)
      @manager_id = GeneralManager.find_by(id: @classified_user.general_manager_id)&.employer_id
    when 'MM'
      @classified_user = MarketingManager.find_by(Employer_id: @current_user.id)
      @manager_id = CsManager.find_by(id: @classified_user.cs_manager_id)&.employer_id
    when 'DM'
      @classified_user = AreaManager.find_by(Employer_id: @current_user.id)
      @manager_id = MarketingManager.find_by(id: @classified_user.marketing_manager_id)&.employer_id
    end
    @manager_name= Employer.find_by(id: @manager_id)&.username
    render json: {errors: ['Un Authorized action']},status: :unauthorized unless @classified_user.present? && @manager_id.present? && @manager_name.present?
  end

end
