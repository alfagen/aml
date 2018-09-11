# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login
  layout 'simple'

  def new
    render :new, locals: { user_session: user_session }
  end

  def create
    if login user_session.login, user_session.password, true
      redirect_back_or_to orders_path, notice: 'Добро пожаловать!'
    else
      flash.now.alert = 'Неверный логин или пароль'
      new
    end
  end

  def destroy
    logout
    flash.now.notice = 'До свидания'
  end

  private

  def user_session
    @user_session ||= UserSession.new params.fetch(:user_session, {}).permit(:login, :password, :remember_me)
  end
end
