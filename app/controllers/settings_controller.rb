# coding: utf-8
class SettingsController < ApplicationController
  layout 'home'
  before_filter :require_login, :init_user

  def basic
    # @user = current_user
    if request.post?
      @user.login = params[:login]
      if @user.save
        flash[:success] = '更新成功'
      else
        flash[:error] = @user.errors.full_messages.last
      end
      redirect_to :back
    end
  end

  def avatar
    # @user = current_user
    if request.post?
      @user.avatar = params[:avatar]
      flash[:error] = @user.errors.full_messages.last unless @user.save
      redirect_to :back
    end
  end

  def reset_password
    # @user = current_user
    if request.post?
      status = current_user.reset_password(params[:orig_password], params[:password], params[:password_confirmation])
      flash[status[0] ? :success : :error] = status[1]
      redirect_to :back
    end
  end

  protected
  def init_user
    @user = current_user
  end
end