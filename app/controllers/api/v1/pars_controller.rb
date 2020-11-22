class Api::V1::ParsController < ApplicationController

  before_action :Authenticate_user
  before_action :Classify_user

  def create

    par= Par.new(pars_params)
    par.status='pending'
    par.employer_id = @classified_user.employer_id
    par.charged_person = @manager_id
    par.track_status= "pending at #{@manager_name}"
    if par.save
      render json: {par: par},status: :created
    else
      render json: {errors: par.errors},status: :unprocessable_entity
    end
  
  end



  def my_pars
    pars= Par.where(employer_id: @classified_user.employer_id).order(updated_at: :desc)
    render json: {pars: pars},status: :ok
  end

  def approval_list
    pars=Par.where(charged_person: @classified_user.employer_id , status: 'pending').order(updated_at: :desc)
    render json: {pars: pars},status: :ok
  end

  def update_par
    par=Par.find_by(id: params[:id])
    if par&.employer_id== @classified_user.employer_id && par&.status == 'pending'
      if par.update(pars_params)
        par.update_attribute(:modified , true)
        render json: {par: par},status: :ok
      else
        render json: {errors: par.errors},status: :unprocessable_entity
      end
    else
      render json: {errors: ['Un Authorized Action']},status: :unauthorized
    end
  end

  #need_test
  def delete_par
    par=Par.find_by(id: params[:id])
    if par&.employer_id== @classified_user.employer_id && par&.status == 'pending'
      if par.delete
        render json: {par: par},status: :ok
      else
        render json: {errors: par.errors},status: :unprocessable_entity
      end
    else
      render json: {errors: ['Un Authorized Action']},status: :unauthorized
    end
  end


  def approve_par
    par=Par.find_by(id: params[:id])

    if par&.charged_person == @classified_user.employer_id && par.status=='pending'
      unless @current_user.role == 'GM'
        par.update_attribute(:charged_person , @manager_id)
        par.update_attribute(:track_status , "pending at #{@manager_name}")
        #Adding status_track field to pars
      else
        par.update_attribute(:status , 'approved')
        par.update_attribute(:track_status , 'completed')
      end
      par.update_attribute(:modified , false)
      par.update_attribute(:comments , nil)
      render json:{par: par},status: :ok
    else
      render json:{errors: ['Un Authorized Action']},status: :unauthorized
    end
  end

  #---- start testing
  def reject_par
    par=Par.find_by(id: params[:id])

    if par&.charged_person == @classified_user.employer_id && par.status=='pending'
        par.update_attribute(:status , 'rejected')
        par.update_attribute(:track_status , "rejected by #{@current_user.username}")
        par.update_attribute(:modified , false)
        par.update_attribute(:comments , nil)
        render json:{par: par},status: :ok
    else
      render json:{errors: ['Un Authorized Action']},status: :unauthorized
    end
  end

  #patch request
  def add_comment
    par=Par.find_by(id: params[:id])

    if par&.charged_person == @classified_user.employer_id && par.status=='pending'
        par.update_attribute(:track_status , "commented by #{@current_user.username}")
        par.update_attribute(:modified , false)
        par.update_attribute(:comments , params.permit(:comments))
        render json:{par: par},status: :ok
    else
      render json:{errors: ['Un Authorized Action']},status: :unauthorized
    end
  end

#-----------------
#SEARCH PARS
#-----------------

  # def team_pars
  #   pars=[]
  #   case @current_user.role 
  #   when 'DM'
  #     team= @classified_user.medical_reps.all 
  #     team.each do |med_rep|
  #       pars.push(Par.where(employer_id: med_rep.employer_id))
  #     end
  #   when 'MM'

  #   when 'CSM'

  #   when 'GM'

  #   end
  #   render json: {pars: pars.flatten},status: :ok
  # end


  def find_par
    par=Par.find_by(id: params[:id])
    pars=[]
    case @current_user.role
    when 'DM'
      med_reps= @classified_user.medical_reps.all
      med_reps.each do |med_rep| 
        pars.push(Par.where(employer_id: med_rep.employer_id))
      end
    when 'MM'
      dms=@classified_user.area_managers.all
      dms.each do |dm| 
        pars.push(Par.where(employer_id: dm.employer_id))
        med_reps= dm.medical_reps.all
        med_reps.each do |med_rep| 
          pars.push(Par.where(employer_id: med_rep.employer_id))
        end
      end
    when 'CSM'
      mms= @classified_user.marketing_managers.all
      mms.each do |mm| 
        pars.push(Par.where(employer_id: mm.employer_id))
        dms=mm.area_managers.all
        dms.each do |dm| 
          pars.push(Par.where(employer_id: dm.employer_id))
          med_reps= dm.medical_reps.all
          med_reps.each do |med_rep| 
            pars.push(Par.where(employer_id: med_rep.employer_id))
          end
        end
      end
    when 'GM'
      pars.push(Par.all)
    end

    pars.push(@current_user.pars)
    pars_list = pars.flatten

    if pars_list.include?(par)
      render json:{par: par},status: :ok
    else
      render json:{errors: ['You don\'t have access to this par']},status: :unauthorized
    end
  end



  private
  def pars_params
    params.permit(:par_type , :description , :value , :client_id , :client_name)
  end

end
