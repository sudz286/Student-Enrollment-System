# README #

---

Platform - Heroku

Link to Application - [application home page](https://mighty-caverns-69337.herokuapp.com/)

---

# Instructions to setup

## Clone the repository
```
git clone https://github.ncsu.edu/kflemin3/StudentEnrollmentSystem.git
```

## Change to parent directory
```
cd StudentEnrollmentSystem
```

## Install dependencies
```
bundle install 
```

## Migrate the database
```
rails db:migrate
```

## Seed the database on localhost
``` 
rails db:seed
```

## Run server on localhost
```
rails server
```

---

## Testing the model
```
rails test test/models/course_test.rb
```

## Testing the controller
```
rails test test/controller/courses_controller_test.rb
```

---

## Sample User Information ##

* Admin
  * **email:** admin@ncsu.edu
  * **password:** 12345
* Max (student)
  * **email:** max@ncsu.edu
  * **password:** 12345
* Jane (student)
  * **email:** jane@ncsu.edu
  * **password:** 12345
* Freja (student)
  * **email:** freja@ncsu.edu
  * **password:** 12345
* Jesse (student)
  * **email:** jesse@ncsu.edu
  * **password:** 12345
* Dr. John (instructor)
  * **email:** john@ncsu.edu
  * **password:** 12345
* Dr. Ellie (instructor)
  * **email:** ellie@ncsu.edu
  * **password:** 12345
* Dr. Octavius (instructor)
  * **email:** octavius@ncsu.edu
  * **password:** 12345

---
## Session Cookies Note ##
If you manage to delete the user you are currently logged in as, you will be unable
to use the application unless you clear your browser cookies. This is unlikely to happen, but please keep it in mind!

---

## Create New Student (While Unauthenticated) Flow ##

* Ensure you are not logged in!
* Visit the [application home page](https://mighty-caverns-69337.herokuapp.com/)
* Click the link to "Create Student Account"
* The new student form is shown
* Fill in all fields
* If there is an error, a flash message will be displayed describing the error
* When you have fixed any errors, press the button to "Create Student Account"
* You will be redirected to the login page, and a flash message will display a success statement
* You may now log in as the student you just created

---

## Create New Instructor (While Unauthenticated) Flow ##

* Ensure you are not logged in!
* Visit the [application home page](https://mighty-caverns-69337.herokuapp.com/)
* Click the link to "Create Instructor Account"
* The new instructor form is shown
* Fill in all fields
* If there is an error, a flash message will be displayed describing the error
* When you have fixed any errors, press the button to "Create Instructor Account"
* You will be redirected to the login page, and a flash message will display a success statement
* You may now log in as the instructor you just created

---

## Successful Login Flow ##

* Ensure you are not logged in!
* Visit the [application home page](https://mighty-caverns-69337.herokuapp.com/)
* Enter an email of a seed account or one you've made
* Enter the corresponding password for the account
* Click the "Login" button
* You will be redirected to the show page for the account type you are logged in as
* A flash message will display a success statement

---

## Unsucessful Login Flow ##

* Ensure you are not logged in!
* Visit the [application home page](https://mighty-caverns-69337.herokuapp.com/)
* Enter an invalid email and/or password
* Click the "Login" button
* You should remain on the login page
* A flash message should explain that the login attempt was invalid

---

## Edit Admin Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "Edit My Profile"
* Make any edits
* Click the button to "Save Changes"
* If there are any errors, a flash message will appear explaining them, and the form will re-render
* If there are no errors, a flash message will appear indicating success, and you'll return to the dashboard
* To confirm changes were successful, click "Edit My Profile" again and confirm that the populated fields match the changes you just made

---

## Admin Create New Instructor Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "Create New Instructor"
* The new instructor form is shown
* Fill in all fields
* If there is an error, a flash message will be displayed describing the error
* When you have fixed any errors, press the button to "Create Instructor Account"
* You will be redirected to the dashboard, and a flash message will display a success statement
* To verify this, click "View All Instructors" and confirm the instructor you just made is present

---

## Admin View All Instructors Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Instructors"
* A list of all instructors in the system will be displayed

---

## Admin Delete Instructor Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Instructors"
* Click the "Delete" button on the instructor you want to delete
* The instructor will be removed from the list
* A flash message will display indicating successful deletion
* If for some reason an error occurs, a flash message will indicate this

---

## Admin Edit Instructor Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Instructors"
* Click the link to edit the instructor you wish to edit
  * For example, if the instructor is "Dr. Miller", the link will say "Edit Dr. Miller"
* The instructor edit form will be displayed
  * The password field will be empty (because it is sensitive information)
  * It can remain visibly empty without change to the actual password
* Make any changes
* Click "Save Changes"
* If there is an error, a flash message will be displayed describing the error
* Otherwise, a flash success message will be displayed and you will be redirected to the instructors index
* Changes to every field but password will be visible here

---

## Admin Create New Student Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "Create New Student"
* The new student form is shown
* Fill in all fields
* Click "Create Student Account"
* If there is an error, a flash message will be displayed describing the error
* When you have fixed any errors, press the button to "Create Student Account"
* You will be redirected to the dashboard, and a flash message will display a success statement
* To verify this, click "View All Students" and confirm the student you just made is present

---

## Admin View All Students Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Students"
* A list of all students in the system will be displayed

---

## Admin Delete Student Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Students"
* Click the "Delete" button on the student you want to delete
* The student will be removed from the list
* A flash message will display indicating successful deletion
* If for some reason an error occurs, a flash message will indicate this

---

## Admin Edit Student Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Students"
* Click the link to edit the student you wish to edit
  * For example, if the instructor is "Freja", the link will say "Edit Freja's Profile"
* The student edit form will be displayed
  * The password field will be empty (because it is sensitive information)
  * It can remain visibly empty without change to the actual password
* Make any changes
* Click "Save Changes"
* If there is an error, a flash message will be displayed describing the error
* Otherwise, a flash success message will be displayed and you will be redirected to the students index
* Changes to some fields will be visible here
* To verify all changes, click the link to edit the same student, and confirm changes are shown in the populated form fields

---

## Admin View Enrollments Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Enrollments"
* Every course enrollment in the system is displayed

---

## Admin View Waitlist Entries Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "View All Waitlist Entries"
* Every waitlist entry in the system is displayed

---

## Admin Create New Course Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "Create New Course"
* The new course form is displayed
* Fill in fields
* Click "Create Course"
* If there are any errors, a flash message will describe them
* Fix any errors, and click "Create Course" again
* You will be redirected to the courses index
* A flash message will indicate the course was created successfully

---

## Admin View All Courses Flow ##
* Log in as admin using credentials provided at the top of this document
* Click "View All Courses"
* Every course in the system is displayed

---

## Admin Edit Course Flow ##
* Log in as admin using credentials provided at the top of this document
* Click "View All Courses"
* Select the link to edit the course you wish to edit
  * For example, "Edit CSC581"
* The edit course form is shown
* Make any changes
* Click "Save Changes"
* If there are any errors, a flash message will describe them
* Fix any errors, and click "Save Changes" again
* You will be redirected to the courses index
* A flash message will indicate the course was updated successfully

---

## Admin View Course Flow ##
* Log in as admin using credentials provided at the top of this document
* Click "View All Courses"
* Select the link to view the course you wish to view
  * For example, "CSC581 Details"
* Details of the course are shown, including any enrolled or waitlisted students

---

## Admin Delete Course Flow ##
* Log in as admin using credentials provided at the top of this document
* Click "View All Courses"
* Click "Delete" on the course you wish to delete
* The course will be removed from the list
* A flash message will display indicating successful deletion
* If for some reason an error occurs, a flash message will indicate this

---

## Admin Enroll Student in a Course Flow ##
* Log in as admin using credentials provided at the top of this document
* On the admin dashboard/profile page, click the link to "Enroll Student in a Course"
* Select the name of the student you wish to enroll
* Select the course you wish to enroll them in
* Click "Enroll Student"
* If there is an unexpected error, or the student is already enrolled/waitlisted, a flash message will appear with an error message
* Otherwise, you will be redirected to the enrollments index, with a flash message indicating success
* The enrollments index will show the enrollment OR the waitlists index will show the waitlist entry

---

## Admin Drop Student From Course Flow ##
* Log in as admin using credentials provided at the top of this document
* Click "View All Courses"
* Select the link to view the course you wish to view
  * For example, "CSC581 Details"
* Details of the course are shown, including any enrolled or waitlisted students
* Click "Drop" on the student you wish to drop from the enrollments or the waitlist entries
* The student will be removed

---

## Student View Enrolled/Waitlisted Courses Flow ##
* Log in as Max using credentials provided at the top of this document
* Lists of all enrolled/waitlists courses will be shown

---

## Student View All Courses Flow ##
* Log in as Max using credentials provided at the top of this document
* Click "View All Courses"
* A list of all courses will be shown

---

## Student Enroll In Course Flow ##
* Log in as Max using credentials provided at the top of this document
* Click "View All Courses"
* Click "Enroll" next to the course you wish for Max to enroll in
* You will be redirected to the dashboard
* A flash message indicating success will be shown
* The course will be shown either under "My Enrolled Courses" or "My Waitlisted Courses"

---

## Student Drop Course Flow ##
* Log in as Max using credentials provided at the top of this document
* Click "Drop" next to the course you wish to drop
* Your dashboard will refresh
* A flash message indicating success will be shown
* The course will no longer be shown in your enrolled or waitlisted courses

---

## Instructor View Own Courses Flow ##
* Log in as Dr. John using credentials provided at the top of this document
* Dr. John's courses will be shown on the dashboard/profile page

---

## Instructor Create New Course Flow ##
* Log in as Dr. John using credentials provided at the top of this document
* Click "Create a New Course"
* The new course form is displayed
* Fill in fields
* Click "Create Course"
* If there are any errors, a flash message will describe them
* Fix any errors, and click "Create Course" again
* You will be redirected to the courses index
* A flash message will indicate the course was created successfully

---

## Instructor Enroll Student In Course ##
* Log in as Dr. John using credentials provided at the top of this document
* Click "Enroll Student in a Course"
* Select the name of the student you wish to enroll
* Select the course you wish to enroll them in
* Click "Enroll Student"
* If there is an unexpected error, or the student is already enrolled/waitlisted, a flash message will appear with an error message
* Otherwise, you will be redirected to the course show page, with a flash message indicating success
* The course show page will show the new enrollment or the new waitlist entry

---

## Instructor Edit Course Flow ##
* Log in as Dr. John using credentials provided at the top of this document
* Select the link to edit the course you wish to edit
  * For example, "Edit CSC581"
* The edit course form is shown
* Make any changes
* Click "Save Changes"
* If there are any errors, a flash message will describe them
* Fix any errors, and click "Save Changes" again
* You will be redirected to your dashboard
* A flash message will indicate the course was updated successfully
* The details page can be viewed to confirm changes

---

## Instructor View Own Course Show Page Flow ##
* Log in as Dr. John using credentials provided at the top of this document
* Dr. John's courses will be shown on the dashboard/profile page
* Select the link to view the course you wish to view
  * For example, "CSC581 Details"
* Details of the course are shown, including any enrolled or waitlisted students

---

## Instructor Delete Own Course Flow ##
* Log in as Dr. John using credentials provided at the top of this document
* Dr. John's courses will be shown on the dashboard/profile page
* Click the "Delete" button on the course you wish to delete
* The course will be removed from the list
* A flash message will display indicating successful deletion
* If for some reason an error occurs, a flash message will indicate this

---
