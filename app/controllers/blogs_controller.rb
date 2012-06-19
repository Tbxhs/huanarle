# coding: utf-8
class BlogsController < ApplicationController
  layout 'home'
  before_filter :require_login, :only => [:new, :create, :destroy]
    
  def index
    init_user
    @blogs = @user.blogs.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
  end

  def new
    @user = current_user
    @blog = @user.blogs.new
  end

  def show
    init_user
    @blog = @user.blogs.find params[:id]
  end

  def create
    @user = current_user
    blog = @user.blogs.create(params[:blog])
    redirect_to user_blog_path(@user, blog)
  end

  def destroy
  end

  private
  def init_user
    # @user = User.find(params[:user_id]) rescue nil
    @user = current_user
    return if @user.nil?
  end
end