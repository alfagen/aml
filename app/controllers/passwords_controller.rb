class PasswordsController < ApplicationController
  def edit
    render :edit, locals: { user: current_user }
  end

  def update
    current_user.update!(permitted_params)
    if permitted_params[:password].present?
      flash.now.notice = 'Пароль изменен'
    else
      flash.now.alert = 'Укажите пароли для изменения'
    end
    redirect_to orders_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now.alert = e.message
    render :edit, locals: { user: e.record }
  end

  private

  def permitted_params
    params.require(:operator).permit(:email, :current_password, :password, :password_confirmation)
  end
end
