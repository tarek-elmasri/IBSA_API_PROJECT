class Client < ApplicationRecord
  validates :client_id , uniqueness: true
end
