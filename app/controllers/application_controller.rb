# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      clear_login_state
      flash[:error] = '请登录后访问'
      redirect_to root_path
    end
  end

  def current_user
    # Note: We have disabled basic_http_auth
    
    @current_user ||= begin
      login_from_session || login_from_cookie
    end

    # @current_user ||= begin
    #   User.current = (login_from_session || login_from_cookie)  
    # end
  end

  # Store the given user id in the session.
  def current_user=(new_user)
    session[:user_id] = new_user ? new_user.id : nil
    @current_user = new_user || nil
    # Cms::User.current = @current_user
  end

  def login_from_session
    self.current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def login_from_cookie
    nil
  end

  def clear_login_state
    current_user = nil
    session[:user_id] = nil
    session.clear
  end

  def render_to_json(response)
    response[:html] ||= ''
    response[:data] ||= {}
    response[:msg] ||= ''
    render :text => {
      :success => response[:success],
      :html => response[:html],
      :data => response[:data],
      :msg => response[:msg]
    }.to_json
  end
end
