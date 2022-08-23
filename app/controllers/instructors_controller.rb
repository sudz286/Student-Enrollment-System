class InstructorsController < ApplicationController
    before_action :authorized, except: [:new, :create]

    def index
        if current_user.admin?
            @instructors = User.where(role: 1)
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user and return
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(instructor_params)
        @user.role = 1
        
        if @user.department == nil or @user.department.length < 1
            flash.alert = "Department cannot be blank"
            redirect_to new_instructor_path and return
        end

        if @user.save
            flash.notice = "Instructor created successfully."
            if !logged_in?
                redirect_to login_path
            else
                redirect_to current_user
            end
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_instructor_path
        end
    end

    def edit
        if current_user.admin?
            @instructor = User.find(params[:id])

            if !@instructor
                flash.alert = "Instructor not found."
                redirect_to current_user and return
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def update
        if current_user.admin?
            @instructor = User.find(params[:id])

            if !@instructor
                flash.alert = "Instructor not found."
                redirect_to current_user and return
            end

            if @instructor.update(instructor_params)
                flash.notice = "Instructor updated successfully."
                redirect_to instructors_path
            else
                flash[:errors] = @instructor.errors.full_messages
                redirect_to edit_instructor_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def destroy
        if current_user.admin?
            # first get all courses owned by this instructor
            courses = Course.where(user_id: params[:id])

            # delete all courses owned by this instructor
            courses.each do |c|
                enrollments = Enrollment.where(course_id: c.id)
                waitlists = Waitlist.where(course_id: c.id)

                if enrollments.length > 0
                    enrollments.each do |e|
                        Enrollment.destroy(e.id)
                    end
                end

                if waitlists.length > 0
                    waitlists.each do |w|
                        Waitlist.destroy(w.id)
                    end
                end

                Course.destroy(c.id)
            end

            if User.destroy(params[:id])
                flash.notice = "Instructor deleted successfully."
                redirect_to instructors_path
            else
                flash.alert = "Something went wrong when deleting the instructor."
                redirect_to instructors_path
            end
        else
            flash.alert = "You do not have permissions to do that."
            redirect_to current_user
        end
    end

    private
    def instructor_params
        params.require(:user).permit(:name, :email, :password, :department, :phone_number, :address)
    end
end