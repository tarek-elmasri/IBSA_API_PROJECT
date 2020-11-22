class AddModifiedToPar < ActiveRecord::Migration[6.0]
  def change
    add_column :pars, :modified, :boolean , default:false
  end
end
