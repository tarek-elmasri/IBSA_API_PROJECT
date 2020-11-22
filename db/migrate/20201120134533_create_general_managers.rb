class CreateGeneralManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :general_managers do |t|
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
