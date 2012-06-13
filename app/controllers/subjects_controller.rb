# coding: utf-8
class SubjectsController < ApplicationController
  layout 'home'
  before_filter :require_login, :init_user

  def index
  end

  def new
  end

  def create
    begin
      subject = @user.subjects.create(:title => params[:title], :remarks => params[:remarks])
      params[:consumptions].each do |k, v|
        subject.consumptions.create :title        =>   v['name'], 
                                    :cost         =>   v['decimal'].to_d, 
                                    :user_id      =>   @user.id,
                                    :category_id  =>   v['category_id'].to_i
      end
      render_to_json(:success => true)
    rescue => e
      render_to_json(:success => false)
    end
  end

  def show
    subject = Subject.find params[:id]
    respond_to do |format|
      format.js {
        html_str = render_to_string(:partial => 'shared/record_detail', :locals => { :subject => subject })
        render_to_json(:success => true, :html => html_str)
      }
    end
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def destroy
    subject = Subject.find params[:id]
    subject.destroy
    respond_to do |format|
      format.js { render_to_json(:success => true) }
    end
  end

  def categories
    @default_cates = %w(衣食住行 游戏 聚餐 女朋友 旅游 房租 水电)

    if request.post? && !params[:name].blank?
      cate = @user.categories.build(:name => params[:name])
      flash[:error] = cate.errors.full_messages.last unless cate.save
      redirect_to :back
      return
    end 
  end

  protected

  def init_user
    @user = current_user
  end

end