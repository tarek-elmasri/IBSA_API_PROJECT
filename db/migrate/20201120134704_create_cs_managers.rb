class CreateCsManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :cs_managers do |t|
      t.references :employer, null: false, foreign_key: true
      t.references :general_manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
