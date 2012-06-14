# coding: utf-8
class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :require_login, :validate_administrator

  def index
    @users = User.paginate(:page => params[:page], :per_page => 20)
    if params[:order_by] == 'login_time'
      @users = @users.order('last_login_at DESC')
    else
      @users = @users.order('created_at DESC')
    end
  end

  def user_blogs
    @blogs = Blog.includes(:user).paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end

  def user_subjects
    @subjects = Subject.includes(:user).paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end

  private

  def validate_administrator
    if current_user.email != Setting.admin_user_email
      redirect_to :root
      return
    end
  end

end