class StudentsController < ApplicationController
    before_action :authorized, except: [:new, :create]
    
    def index
        if current_user.admin?
            @students = User.where(role: 2)
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(student_params)
        @user.role = 2 # Can probably index into User role enum?

        if @user.major == nil or @user.major.length < 1
            flash.alert = "Major cannot be blank"
            redirect_to new_student_path and return
        end

        if !@user.date_of_birth
            flash.alert = "Date of birth cannot be blank"
            redirect_to new_student_path and return
        end

        if @user.student_id == nil or @user.student_id.length < 1
            flash.alert = "Student ID cannot be blank"
            redirect_to new_student_path and return
        else
            @students = User.where(role: 2, student_id: @user.student_id)
            if @students.length > 0
                flash.alert = "Student ID must be unique"
                redirect_to new_student_path and return
            end
        end

        if @user.save
            flash.notice = "Student created successfully."
            if !logged_in?
                redirect_to login_path
            else
                redirect_to current_user
            end
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_student_path
        end
    end

    def edit
        if current_user.admin?
            @student = User.find(params[:id])

            if !@student
                flash.alert = "Student not found."
                redirect_to current_user and return
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user and return
        end
    end

    def update
        if current_user.admin?
            @student = User.find(params[:id])

            if !@student
                flash.alert = "Student not found."
                redirect_to current_user and return
            end
        
            if params[:user][:major] == nil or params[:user][:major].length < 1
                flash.alert = "Major cannot be blank"
                redirect_to edit_student_path(id: @student.id) and return
            end
    
            if !params[:user][:date_of_birth]
                flash.alert = "Date of birth cannot be blank"
                redirect_to edit_student_path(id: @student.id) and return
            end
    
            if params[:user][:student_id] == nil or params[:user][:student_id].length < 1
                flash.alert = "Student ID cannot be blank"
                redirect_to edit_student_path(id: @student.id) and return
            else
                @students = User.where(role: 2)
                
                @filteredStudents = @students.select do |s|
                    s.id != params[:id].to_i
                end

                @filteredStudents.each do |s|
                    if s.student_id == params[:user][:student_id]
                        flash.alert = "Student ID must be unique"
                        redirect_to edit_student_path(id: @student.id) and return
                    end
                end
            end

            if @student.update(student_params)
                flash.notice = "Student updated successfully."
                redirect_to students_path
            else
                flash[:errors] = @student.errors.full_messages
                redirect_to edit_student_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def destroy
        if current_user.admin?
            #first any enrollments or waitlist entries related to
            # this student must be destroyed
            enrollments = Enrollment.where(user_id: params[:id])
            waitlists = Waitlist.where(user_id: params[:id])

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

            # finally, the student can be destroyed
            if User.destroy(params[:id])
                # flash success message
                flash.notice = "Student successfully deleted."
                redirect_to students_path
            else
                flash.alert = "Something went wrong when destroying student."
                redirect_to students_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    private
        def student_params
            params.require(:user).permit(:name, :email, :password, :student_id,
            :major, :phone_number, :address, :date_of_birth)
        end
end