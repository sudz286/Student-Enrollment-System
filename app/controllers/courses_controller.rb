class CoursesController < ApplicationController
    before_action :authorized

    def index
        if current_user.admin? or current_user.student?
            @courses = Course.all
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end
    
    def new
        if current_user.admin? or current_user.instructor?
            @course = Course.new
            @instructors = User.where(role: 1)
            @weekdays = {:MON => {:name => "MON", :val => 0}, :TUE => {:name => "TUE", :val => 1}, 
            :WED => {:name => "WED", :val => 2}, :THU => {:name => "THU", :val => 3}, 
            :FRI => {:name => "FRI", :val => 4}, :none => {:name => "none", :val => nil}}
            @status = %i(OPEN CLOSED WAITLIST)
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def show
        @course = Course.find(params[:id])
        if current_user.admin? or (current_user.instructor? and current_user.id == 
            @course.user_id)

            if !@course
                flash.alert = "Course not found."
                redirect_to current_user and return
            end

            enrollments = Enrollment.where(course_id: params[:id])
            waitlists = Waitlist.where(course_id: params[:id])
            @enrolledStudents = enrollments.collect do |e|
                {:student => User.find(e.user_id), :enrollment => e}
            end
            @waitlistedStudents = waitlists.collect do |w|
                {:student => User.find(w.user_id), :waitlist => w}
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def create
        if current_user.admin? or current_user.instructor?
            @course = Course.new(course_params)

            if @course.save
                flash.notice = "Course created successfully."
                redirect_to courses_path
            else
                flash[:errors] = @course.errors.full_messages
                redirect_to new_course_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def edit
        @course = Course.find(params[:id])
        if current_user.admin? or (current_user.instructor? and current_user.id == @course.user_id)
            
            if !@course
                flash.alert = "Course not found."
                redirect_to current_user and return
            end

            @instructors = User.where(role: 1)
            @weekdays = {:MON => {:name => "MON", :val => 0}, :TUE => {:name => "TUE", :val => 1}, 
            :WED => {:name => "WED", :val => 2}, :THU => {:name => "THU", :val => 3}, 
            :FRI => {:name => "FRI", :val => 4}, :none => {:name => "none", :val => nil}}
            @status = %i(OPEN CLOSED WAITLIST)
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def update
        @course = Course.find(params[:id])
        if current_user.admin? or (current_user.instructor? and current_user.id == @course.user_id)
            
            if !@course
                flash.alert = "Course not found."
                redirect_to current_user and return
            end

            if @course.update(course_params)
                flash.notice = "Course updated successfully."
                redirect_to courses_path
            else
                flash[:errors] = @course.errors.full_messages
                redirect_to edit_course_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def destroy
        course = Course.find(params[:id])

        if current_user.admin? or (current_user.instructor? and current_user.id == course.user_id)
            if !course
                flash.alert = "Course not found."
                redirect_to current_user and return
            end
            # to destroy a course, you must first destroy associated enrollments
            # and associated waitlist entries
            enrollments = Enrollment.where(course_id: params[:id])
            waitlists = Waitlist.where(course_id: params[:id])
            if enrollments.length > 0
                enrollments.each do |e|
                    # for now, assuming this works
                    Enrollment.destroy(e.id)
                end
            end
            if waitlists.length > 0
                waitlists.each do |w|
                    # for now, assuming this works
                    Waitlist.destroy(w.id)
                end
            end

            # finally, we can destroy the course
            if Course.destroy(params[:id])
                flash.notice = "Course destroyed successfully."
                redirect_to courses_path
            else
                flash.alert = "Something went wrong when destroying the course."
                redirect_to courses_path
            end
        else
            flash.notice = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    private
    def course_params
        params.require(:course).permit(:user_id, :name, :description, :weekday_one, :weekday_two, :start_time, :end_time,
        :room, :capacity, :course_code, :waitlist_capacity, :status)
    end
end