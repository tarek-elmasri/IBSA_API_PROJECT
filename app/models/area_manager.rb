class AreaManager < ApplicationRecord
  belongs_to :employer
  belongs_to :marketing_manager
  has_many :medical_reps
  has_many :pars
  
end
