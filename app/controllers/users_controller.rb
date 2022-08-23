class UsersController < ApplicationController
    before_action :authorized
    
    # GET /users
    def index
        if current_user.admin?
            @users = User.all
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    # GET /users/:id
    def show
        @user = User.find(params[:id])

        if !@user
            flash.alert = "User not found."
           redirect_to login_path and return 
        end

        if @user.student?
            enrollments = Enrollment.where(user_id: @user.id)
            waitlists = Waitlist.where(user_id: @user.id)
            @enrolledCourses = enrollments.collect do |e|
                {:enrollment => e, :course => Course.find(e.course_id)}
            end
            @waitlistedCourses = waitlists.collect do |w|
                {:waitlist => w, :course => Course.find(w.course_id)}
            end
        end
        if @user.instructor?
            @courses = Course.where(user_id: @user.id)
        end
    end

    # GET /users/new
    def new
        if current_user.admin?
            @user = User.new
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    # POST /users
    def create
        if current_user.admin?
            @user = User.create(user_params)

            if @user.save
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    # DELETE /users
    def destroy
        if current_user.admin?
            # Simple case, for now
            @user = User.find(params[:id])
            @user.destroy
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :department, :phone_number, :student_id, :date_of_birth, :major, :role, :address)
    end
end