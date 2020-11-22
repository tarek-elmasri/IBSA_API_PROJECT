class CsManager < ApplicationRecord
  belongs_to :employer
  belongs_to :general_manager
  has_many :marketing_managers
  has_many :pars
  
end
