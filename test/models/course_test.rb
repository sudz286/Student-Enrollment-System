require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "saving a valid course" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(user_id: user[:id], name: "Computer Graphics", description: "This is a sample course", weekday_one: 1, weekday_two: 2, start_time:  Time.new(2022, 10, 31, 2, 2, 2), end_time: Time.new(2022, 10, 31, 3, 2, 2), course_code: "EBB123", capacity: 12, waitlist_capacity: 1, status: 0, room: "EB123") 
    assert c.save
    Course.destroy(c.id)
  end

  test "saving a course with invalid course code" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Algebra", :description => "Algebra", :weekday_one => 1, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2) , :course_code => "EB124", :capacity => 12, :waitlist_capacity => 1, :status => 0, :room => "EB123")
    assert_not c.save
  end

  test "saving a course with duplicate course code" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    course1 = Course.new(user_id: user[:id], name: "Computer Graphics", description: "This is a sample course", weekday_one: 1, weekday_two: 2, start_time:  Time.new(2022, 10, 31, 2, 2, 2), end_time: Time.new(2022, 10, 31, 3, 2, 2), course_code: "EBB123", capacity: 12, waitlist_capacity: 1, status: 0, room: "EB123") 
    course1.save
    c = Course.new(:user_id => user[:id], :name => "Models", :description => "This is a sample course", :weekday_one => 1, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2), :course_code => "EBB123", :capacity => 12, :waitlist_capacity => 0, :status => 1, :room => "EB123") 
    assert_not c.save
  end

  test "saving a course with empty description attribute" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Linear Algebra", :description => "", :weekday_one => 1, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2), :course_code => "EBB128", :capacity => 12, :waitlist_capacity => 1, :status => 0, :room => "EBB 127") 
    assert_not c.save
  end 

  test "saving a course with empty weekday_one attribute" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Linear Algebra", :description => "This is LA", :weekday_one => nil, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2), :course_code => "EBB128", :capacity => 12, :waitlist_capacity => 1, :status => 0, :room => "EBB 127")
    p c.save
    assert_not c.save
  end

  test "saving a course with empty start_time attribute" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Linear Algebra", :description => "", :weekday_one => 1, :weekday_two => 2, :start_time => nil, :end_time => Time.new(2020, 10, 31, 3, 2, 2), :course_code => "EBB128", :capacity => 12, :waitlist_capacity => 1, :status => 0, :room => "EBB 127")
    assert_not c.save
  end

  test "saving a course with empty room attribute" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Linear Algebra", :description => "", :weekday_one => 1, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2), :course_code => "EBB128", :capacity => 12, :waitlist_capacity => 1, :status => 0)
    assert_not c.save
  end

  test "saving a course where end time is before or equal to start time" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Algebra", :description => "Algebra", :weekday_one => 1, :weekday_two => 2, :start_time => Time.now, :end_time => Time.now , :course_code => "EB124", :capacity => 12, :waitlist_capacity => 1, :status => 1, :room => "EB123")
    assert_not c.save
  end

  test "saving a course where weekday one is the same value as weekday two" do
    user = User.new(name: "Sample User", email: "sample@ncsu.edu", password_digest: "1234", department: "CS", phone_number: "1234567891", role: "instructor")
    user.save
    c = Course.new(:user_id => user[:id], :name => "Algebra", :description => "Algebra", :weekday_one => 2, :weekday_two => 2, :start_time => Time.new(2020, 10, 31, 2, 2, 2), :end_time => Time.new(2020, 10, 31, 3, 2, 2) , :course_code => "EB124", :capacity => 12, :waitlist_capacity => 1, :status => 0, :room => "EB123")
    assert_not c.save
  end

end