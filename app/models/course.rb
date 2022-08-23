class Course < ApplicationRecord
    belongs_to :user
    enum weekdays: %i(MON TUE WED THU FRI nil)
    enum status: %i(OPEN CLOSED WAITLIST)
    # Validations
    validates :name, :description, :start_time, :end_time, :course_code, :weekday_one, :capacity, :room, presence: true
    validates_uniqueness_of :course_code
    validates :course_code, format: { with: /[a-zA-Z]{3}\d{3}/, message: "Course code follows the format of 3 letters followed by 3 numbers (no spaces)"}
    validates :end_time, comparison: { greater_than: :start_time, message: "End time cannot be lesser than start time"}
    validates :weekday_two, exclusion: { in: ->(course) {[course.weekday_one]} }
end