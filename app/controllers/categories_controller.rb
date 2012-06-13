# coding: utf-8

class CategoriesController < ApplicationController
  before_filter :require_login

  def index
    respond_to do |format|
      format.js { 
        html_str = render_to_string(:partial => 'shared/user_categories')
        render_to_json(:success => true, :html => html_str)
      }
    end    
  end

  def show

  end

  def create
    @user = current_user
    begin
      cate = @user.categories.build(:name => params[:name])
      render_to_json(:success => cate.save, :data => { :id => cate.id })
    rescue => e
      render_to_json(:success => false)
    end
  end

  def update
    @user = current_user
    begin
      cate = Category.find params[:cate_id]
      cate.name = params[:name] if cate.user_id == @user.id        
      render_to_json(:success => cate.save)
    rescue
      render_to_json(:success => false)
    end
  end

  def destroy
    @user = current_user
    begin
      cate = Category.find params[:cate_id]
      cate.destroy if cate.user_id == @user.id
      render_to_json(:success => true)
    rescue
      render_to_json(:success => false)
    end    
  end

end