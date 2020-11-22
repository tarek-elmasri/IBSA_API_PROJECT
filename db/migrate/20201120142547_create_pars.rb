class CreatePars < ActiveRecord::Migration[6.0]
  def change
    create_table :pars do |t|
      t.references :employer, null: false, foreign_key: true
      t.string :par_type
      t.text :description
      t.string :status
      t.integer :charged_person
      t.text :comments
      t.integer :value
      t.integer :client_id
      t.string :client_name

      t.timestamps
    end
  end
end
