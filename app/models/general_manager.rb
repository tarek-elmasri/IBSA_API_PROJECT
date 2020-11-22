class GeneralManager < ApplicationRecord
  belongs_to :employer
  has_many :cs_managers
  
end
