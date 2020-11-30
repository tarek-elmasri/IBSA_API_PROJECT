class Par < ApplicationRecord
  belongs_to :employer

  validates :description , presence: true
end
