# coding: utf-8
class AuthController < ApplicationController

  def weibo_login
    begin
      auth = request.env["omniauth.auth"]
      user = User.find_or_create_from_auth(auth)
      self.current_user = user 
      redirect_to home_path
    rescue => e
      # raise e
      flash[:error] = '授权过程中出错，请重试'
      redirect_to :root
    end
  end

end