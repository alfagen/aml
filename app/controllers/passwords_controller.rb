class PasswordsController < ApplicationController
  def edit
    render :edit, locals: { user: current_user }
  end

  def update
    current_user.update! permitted_params

    flash.now.notice = 'Пароль установлен'

    redirect_to orders_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now.alert = e.message
    render :edit, locals: { user: e.record }
  end

  private

  def permitted_params
    params.require(:operator).permit(:email, :password, :password_confirmation, :current_password)
  end
end
