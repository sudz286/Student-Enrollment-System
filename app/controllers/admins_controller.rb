class AdminsController < ApplicationController
    before_action :authorized

    def edit
        if current_user.admin?
            @admin = User.where(id: params[:id], role: 0)[0]

            if !@admin
                flash.alert = "Admin could not be found."
                redirect_to current_user
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    def update
        if current_user.admin?
            @admin = User.find(params[:id])

            if !@admin
                flash.alert = "Admin could not be found."
                redirect_to current_user and return
            end

            if @admin.update(admin_params)
                flash.notice = "Admin successfully updated."
                redirect_to @admin
            else
                flash[:errors] = @admin.errors.full_messages
                redirect_to edit_admin_path
            end
        else
            flash.alert = "You do not have permission to do that."
            redirect_to current_user
        end
    end

    private
    def admin_params
        params.require(:user).permit(:name, :phone_number)
    end
end