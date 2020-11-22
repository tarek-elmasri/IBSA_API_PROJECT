Rails.application.routes.draw do

  
  namespace :api do
    namespace :v1 do
      post 'sessions/auth_by_email_and_password' => 'sessions#auth_by_email_and_password'
      get 'sessions/auth_by_token' => 'sessions#auth_by_token'

      post 'requests/new' => 'pars#create'
      get 'requests/my_pars' => 'pars#my_pars'
      get 'requests/approval_list' => 'pars#approval_list'
      get 'requests/approve_par' => 'pars#approve_par'
      patch 'requests/update_par' => 'pars#update_par'
      get 'requests/find_par' => 'pars#find_par'
      #needs tests
      delete 'requests/delete_par' => 'pars#delete_par'
      patch 'requests/add_comment' => 'pars#add_comment'
      #tested
      get 'sessions/find_par' => 'pars#find_par'

    end
  end

  
end
