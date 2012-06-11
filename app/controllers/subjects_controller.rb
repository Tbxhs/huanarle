# coding: utf-8
class SubjectsController < ApplicationController
  layout 'home'
  before_filter :require_login

  def index
  end

  def new
    @user = current_user
  end

  def create
    @user = current_user
    begin
      subject = @user.subjects.create(:title => params[:title], :remarks => params[:remarks])
      params[:consumptions].each do |k, v|
        subject.consumptions.create(:title => v['name'], :cost => v['decimal'].to_d, :user_id => @user.id)
      end
      render_to_json(:success => true)
    rescue => e
      p "1111111-----------"
      p e.inspect
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
    @user = current_user
    @subject = Subject.find params[:id]
  end

  def destroy
    @user = current_user
    subject = Subject.find params[:id]
    subject.destroy
    respond_to do |format|
      format.js { render_to_json(:success => true) }
    end
  end

end