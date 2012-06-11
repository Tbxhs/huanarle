# coding: utf-8
class IndexController < ApplicationController
  layout 'public'
  before_filter :check_logged_in, :except => :sign_out
  before_filter :require_login, :only => :sign_out

  def index
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user.present?
        self.current_user = user
        user.update_recorded_days_after_login
        redirect_to home_path
      else
        flash[:error] = '用户名或者密码错误'
        redirect_to :root
      end
    end
  end

  def sign_out
    clear_login_state
    redirect_to :root
  end

  def sign_up
    if request.post?
      user = User.new
      user.login = params[:login]
      user.email = params[:email]
      user.password = params[:password]
      user.password_confirmation = params[:password]
      user.last_login_at = Time.now
      if user.save
        self.current_user = user
      else
        flash[:error] = user.errors.full_messages.last
      end
      redirect_to :back
    end
  end

  private
  def check_logged_in 
    if logged_in?
      redirect_to home_path
      return
    end
  end
end