class AddClientIdToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :client_id, :integer
  end
end
