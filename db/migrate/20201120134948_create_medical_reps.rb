class CreateMedicalReps < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_reps do |t|
      t.references :employer, null: false, foreign_key: true
      t.references :area_manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
