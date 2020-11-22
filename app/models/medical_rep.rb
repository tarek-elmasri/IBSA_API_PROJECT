class MedicalRep < ApplicationRecord
  belongs_to :employer
  belongs_to :area_manager
  has_many :pars
  
end
