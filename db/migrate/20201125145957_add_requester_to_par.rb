class AddRequesterToPar < ActiveRecord::Migration[6.0]
  def change
    add_column :pars, :requester, :string
  end
end
