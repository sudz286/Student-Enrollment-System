class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :department
      t.string :phone_number
      t.string :student_id
      t.datetime :date_of_birth
      t.string :major
      t.integer :role
      t.text :address

      t.timestamps
    end
  end
end
