class WaitlistsController < ApplicationController
    def index
        if current_user.admin?
            @waitlists = Waitlist.all
        else
            flash.alert = "You do not have permission to that."
            redirect_to current_user
        end
    end

    def destroy
        entry = Waitlist.find(params[:id])
        course = Course.find(entry.course_id)

        # if the waitlist was full
        if course.CLOSED?
            # drop the student to free up one spot
            Waitlist.destroy(params[:id])
            # waitlist can be added to again
            course.WAITLIST!
            # save changes to course
            if !course.save
                flash.alert = "Something went wrong!"
                if current_user.admin?
                    redirect_to waitlists_path and return
                elsif current_user.instructor?
                    redirect_to course_path(id: course.id) and return
                else
                    redirect_to current_user and return
                end
            else
                if current_user.admin?
                    flash.notice = "Waitlist entry destroyed successfully."
                    redirect_to waitlists_path and return
                elsif current_user.instructor?
                    flash.notice = "Student dropped from waitlist successfully."
                    redirect_to course_path(id: course.id) and return
                else
                    flash.notice = "You are no longer waitlisted for the course."
                    redirect_to current_user and return
                end
            end
        else
            # course status doesn't need to change, just drop
            Waitlist.destroy(params[:id])
        end

        if current_user.admin?
            flash.notice = "Waitlist entry destroyed successfully."
            redirect_to waitlists_path and return
        elsif current_user.instructor?
            flash.notice = "Student dropped from waitlist successfully."
            redirect_to course_path(id: course.id) and return
        else
            flash.notice = "You are no longer waitlisted for the course."
            redirect_to current_user and return
        end
    end
end