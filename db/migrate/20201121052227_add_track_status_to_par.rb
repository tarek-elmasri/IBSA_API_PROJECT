class AddTrackStatusToPar < ActiveRecord::Migration[6.0]
  def change
    add_column :pars, :track_status, :string
  end
end
