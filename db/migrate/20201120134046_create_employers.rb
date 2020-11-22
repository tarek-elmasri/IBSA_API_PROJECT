class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
    add_index :employers, :email, unique: true
  end
end
