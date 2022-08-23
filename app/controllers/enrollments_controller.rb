class EnrollmentsController < ApplicationController
    before_action :authorized

    def index
        if current_user.admin?
            @enrollments = Enrollment.all
        else
            flash.notice = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def new
        if current_user.admin? or current_user.instructor?
            @students = User.where(role: 2)
            if current_user.admin?
                @courses = Course.all
            elsif current_user.instructor?
                @courses = Course.where(user_id: current_user.id)
            end
            @enrollment = Enrollment.new
        else
            flash.notice = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def create
        # get course
        course_id = params[:enrollment][:course_id].to_i
        user_id = params[:enrollment][:user_id].to_i
        course = Course.find(course_id)

        if !course
            flash.alert = "Course not found."
            redirect_to current_user and return
        end

        # check to see if student is already enrolled
        duplicateEnrollment = Enrollment.where(course_id: course_id, user_id: user_id)
        waitlistEnrollment = Waitlist.where(course_id: course_id, user_id: user_id)
        if duplicateEnrollment.length > 0 or waitlistEnrollment.length > 0
            if current_user.admin? or current_user.instructor?
                flash.alert = "This student is already enrolled or waitlisted for this course."
                redirect_to new_enrollment_path and return
            else
                flash.alert = "You are already enrolled or waitlisted in this course."
                redirect_to courses_path and return
            end
        end

        # if course is OPEN, enroll student
        if course.OPEN?
            @enrollment = Enrollment.new(enrollment_params)

            if @enrollment.save
                numEnrolled = Enrollment.where(course_id: course.id).length

                if numEnrolled == course.capacity
                    # this student got the last open spot
                    # if the course has a waitlist, set status to WAITLIST
                    if course.waitlist_capacity > 0 # or not nil
                        course.WAITLIST!
                    else
                        # otherwise, set status to CLOSED
                        course.CLOSED!
                    end

                    # save changes to course
                    if !course.save
                        flash.alert = "Something went wrong!"
                        if current_user.admin? or current_user.instructor?
                            redirect_to new_enrollment_path and return
                        else
                            redirect_to courses_path and return
                        end
                    end
                end
            else
                flash[:errors] = @enrollment.errors.full_messages
                if current_user.admin? or current_user.instructor?
                    redirect_to new_enrollment_path and return
                else
                    redirect_to courses_path and return
                end
            end
        elsif course.WAITLIST?
            # put student on waitlist
            waitlist = Waitlist.new(course_id: course_id, user_id: user_id)

            if waitlist.save
                numWaitlist = Waitlist.where(course_id: course_id).length

                if numWaitlist == course.waitlist_capacity
                    # this student got the last waitlist spot
                    # course is now CLOSED
                    course.CLOSED!
                    # save changes to course
                    if !course.save
                        flash.alert = "Something went wrong!"
                        if current_user.admin? or current_user.instructor?
                            redirect_to new_enrollment_path and return
                        else
                            redirect_to courses_path and return
                        end
                    end
                end
            else
                flash[:errors] = waitlist.errors.full_messages
                if current_user.admin? or current_user.instructor?
                    redirect_to new_enrollment_path and return
                else
                    redirect_to courses_path and return
                end
            end
        else
            # course is CLOSED
            flash.alert = "Cannot enroll or waitlist--the course is closed."
            if current_user.admin? or current_user.instructor?
                redirect_to new_enrollment_path and return
            end
        end

        flash.notice = "Successfully enrolled or waitlisted for #{course.course_code}."
        if current_user.admin?
            redirect_to enrollments_path and return
        elsif current_user.instructor?
            redirect_to course_path(id: course_id) and return
        else
            redirect_to current_user and return
        end
    end

    def destroy
        enrollment = Enrollment.find(params[:id])
        course = Course.find(enrollment.course_id)

        if !course
            flash.alert = "Course not found."
            redirect_to current_user and return
        end

        if !enrollment
            flash.alert = "Enrollment not found."
            redirect_to current_user and return
        end

        if course.OPEN?
            # just remove the enrollment! easy
            Enrollment.destroy(params[:id])
            if current_user.admin?
                flash.notice = "Enrollment destroyed successfully."
                redirect_to enrollments_path and return
            elsif current_user.instructor?
                flash.notice = "Student dropped successfully."
                redirect_to course_path(id: course.id) and return
            else
                flash.notice = "You are no longer enrolled in the course."
                redirect_to current_user and return
            end
        elsif course.WAITLIST?
            # destroy the enrollment
            Enrollment.destroy(params[:id])
            # find the first student on this course's waitlist
            waitlistEntries = Waitlist.where(course_id: enrollment.course_id)
            earliestEntry = waitlistEntries.min do |a, b|
                a.created_at <=> b.created_at
            end
            if earliestEntry
                # enroll the waitlisted student
                newEnrollment = Enrollment.new(course_id: earliestEntry.course_id, user_id: earliestEntry.user_id)
                if newEnrollment.save
                    # delete the student from the waitlist
                    Waitlist.destroy(earliestEntry.id)
                    if current_user.admin?
                        flash.notice = "Enrollment destroyed successfully."
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        flash.notice = "Student dropped successfully."
                        redirect_to course_path(id: course.id) and return
                    else
                        flash.notice = "You are no longer enrolled in the course."
                        redirect_to current_user and return
                    end
                else
                    flash[:errors] = newEnrollment.errors.full_messages
                    if current_user.admin?
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        redirect_to course_path(id: course.id) and return
                    else
                        redirect_to current_user and return
                    end
                end
            else
                # waitlist is empty
                # course is now open because there's an open slot
                course.OPEN!
                if !course.save
                    flash.alert = "Something went wrong!"
                    if current_user.admin?
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        redirect_to course_path(id: course.id) and return
                    else
                        redirect_to current_user and return
                    end
                else
                    if current_user.admin?
                        flash.notice = "Enrollment destroyed successfully."
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        flash.notice = "Student dropped successfully."
                        redirect_to course_path(id: course.id) and return
                    else
                        flash.notice = "You are no longer enrolled in the course."
                        redirect_to current_user and return
                    end
                end
            end
        else
            # course is closed
            # does this course have a waitlist?
            if course.waitlist_capacity > 0 # or not nil
                # destroy the enrollment
                Enrollment.destroy(params[:id])
                # find the first student on this course's waitlist
                waitlistEntries = Waitlist.where(course_id: enrollment.course_id)
                earliestEntry = waitlistEntries.min do |a, b|
                    a.created_at <=> b.created_at
                end
                # enroll the waitlisted student
                newEnrollment = Enrollment.new(course_id: earliestEntry.course_id, user_id: earliestEntry.user_id)
                if newEnrollment.save
                    # delete the student from the waitlist
                    Waitlist.destroy(earliestEntry.id)
                    # waitlist is no longer full, someone else can get on it
                    course.WAITLIST!
                    if !course.save
                        flash.alert = "Something went wrong!"
                        if current_user.admin?
                            redirect_to enrollments_path and return
                        elsif current_user.instructor?
                            redirect_to course_path(id: course.id) and return
                        else
                            redirect_to current_user
                        end
                    else
                        # flash a success message
                        if current_user.admin?
                            flash.notice = "Enrollment destroyed successfully."
                            redirect_to enrollments_path and return
                        elsif current_user.instructor?
                            flash.notice = "Student dropped successfully."
                            redirect_to course_path(id: course.id) and return
                        else
                            flash.notice = "You are no longer enrolled in the course."
                            redirect_to current_user
                        end
                    end
                else
                    flash[:errors] = newEnrollment.errors.full_messages
                    if current_user.admin?
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        redirect_to course_path(id: course.id) and return
                    else
                        redirect_to current_user
                    end
                end
            else
                # destroy the enrollment
                Enrollment.destroy(params[:id])
                # now there's an open spot
                course.OPEN!
                if !course.save
                    # flash an error message
                    flash.alert "Something went wrong!"
                    if current_user.admin?
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        redirect_to course_path(id: course.id) and return
                    else
                        redirect_to current_user
                    end
                else
                    # flash a success message
                    if current_user.admin?
                        flash.notice = "Enrollment destroyed successfully."
                        redirect_to enrollments_path and return
                    elsif current_user.instructor?
                        flash.notice = "Student dropped successfully."
                        redirect_to course_path(id: course.id) and return
                    else
                        flash.notice = "You are no longer enrolled in the course."
                        redirect_to current_user
                    end
                end
            end
        end
    end

    private
    def enrollment_params
        params.require(:enrollment).permit(:user_id, :course_id)
    end
end