class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(
                                  :username,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :current_password,
                                  :first_name,
                                  :last_name,
                                  :age,
                                  :gender,
                                  :birthday,
                                  :bio,
                                  :relationship,
                                  :work,
                                  :previous_jobs,
                                  :education,
                                  :previous_education,
                                  :address,
                                  :city,
                                  :state,
                                  :zip,
                                  :country,
                                  :phone,
                                  :avatar,
                                  :cover_image
                          )
  end

end