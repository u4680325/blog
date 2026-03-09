class ProfilesController < ApplicationController
  def edit
  end

  def update
    unless Current.user.authenticate(params[:current_password])
      return redirect_to edit_profile_path, alert: "Current password is incorrect."
    end

    if Current.user.update(params.permit(:password, :password_confirmation))
      redirect_to edit_profile_path, notice: "Password updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
