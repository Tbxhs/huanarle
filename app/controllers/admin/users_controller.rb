# coding: utf-8
class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :require_login, :validate_administrator

  def index
    @users = User.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end

  private

  def validate_administrator
    if current_user.email != 'bzu_2007@126.com' || current_user.login != 'laohuang'
      redirect_to :root
    end
  end

end