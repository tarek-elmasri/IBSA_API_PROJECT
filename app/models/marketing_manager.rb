class MarketingManager < ApplicationRecord
  belongs_to :employer
  belongs_to :cs_manager
  has_many :area_managers
  has_many :pars
  
end
