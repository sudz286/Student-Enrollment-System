class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :description
      t.integer :weekday_one
      t.integer :weekday_two
      t.time :start_time
      t.time :end_time
      t.string :course_code
      t.integer :capacity
      t.integer :waitlist_capacity
      t.integer :status
      t.string :room
      t.timestamps
    end
  end
end
