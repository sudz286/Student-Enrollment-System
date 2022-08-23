# bin/rails db:seed command

# PRE-CONFIGURED ADMIN
User.create(name: "Admin", email: "admin@ncsu.edu", password: "12345", department: nil, phone_number: "15551234", student_id: nil, date_of_birth: nil, major: nil, role: 0, address: "123 Admin Road")

# PRE-CONFIGURED STUDENTS
User.create(name: "Max", email: "max@ncsu.edu", password: "12345", student_id: "max", major: "Computer Science", phone_number: "15555551234", address: "123 Max Road", date_of_birth: DateTime.now, role: 2)
User.create(name: "Jane", email: "jane@ncsu.edu", password: "12345", student_id: "jane", major: "Computer Science", phone_number: "15555551234", address: "123 Jane Road", date_of_birth: DateTime.now, role: 2)
User.create(name: "Freja", email: "freja@ncsu.edu", password: "12345", student_id: "freja", major: "Computer Science", phone_number: "15555551234", address: "123 Freja Road", date_of_birth: DateTime.now, role: 2)
User.create(name: "Jesse", email: "jesse@ncsu.edu", password: "12345", student_id: "jesse", major: "Computer Science", phone_number: "15555551234", address: "123 Jesse Road", date_of_birth: DateTime.now, role: 2)

# PRE-CONFIGURED INSTRUCTORS
User.create(name: "Dr. John", email: "john@ncsu.edu", password: "12345", address: "123 John Road", phone_number: "15555551234", department: "CSC", role: 1)
User.create(name: "Dr. Ellie", email: "ellie@ncsu.edu", password: "12345", address: "123 Ellie Road", phone_number: "15555551234", department: "CSC", role: 1)
User.create(name: "Dr. Octavius", email: "octavius@ncsu.edu", password: "12345", address: "123 Octavius Road", phone_number: "15555551234", department: "CSC", role: 1)

# PRE-CONFIGURED COURSES
john = User.find_by(email: "john@ncsu.edu")
Course.create(name: "Compiler Construction", description: "Study the design of compilers and implement a compiler.", user_id: john.id, weekday_one: 0, weekday_two: 2, start_time: Time.now, end_time: Time.now + (60*60*2), course_code: "CSC512", capacity: 1, waitlist_capacity: 2, status: "OPEN", room: "1400 EB2")
ellie = User.find_by(email: "ellie@ncsu.edu")
Course.create(name: "Game Engines", description: "Implement a game engine over several assignments.", user_id: ellie.id, weekday_one: 1, weekday_two: 3, start_time: Time.now, end_time: Time.now + (60*60*2), course_code: "CSC581", capacity: 25, waitlist_capacity: 5, status: "CLOSED", room: "1550 EB2")
octavius = User.find_by(email: "octavius@ncsu.edu")
Course.create(name: "AI for Games", description: "Study typical AI methods for games.", user_id: octavius.id, weekday_one: 4, weekday_two: nil, start_time: Time.now, end_time: Time.now + (60*60*2), course_code: "CSC484", capacity: 10, waitlist_capacity: 5, status: "OPEN", room: "2100 EB2")