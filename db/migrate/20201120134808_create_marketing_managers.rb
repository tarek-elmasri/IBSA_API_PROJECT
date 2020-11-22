class CreateMarketingManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :marketing_managers do |t|
      t.references :employer, null: false, foreign_key: true
      t.references :cs_manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
