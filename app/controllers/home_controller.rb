# coding: utf-8
class HomeController < ApplicationController
  layout 'home'
  before_filter :require_login
  
  def index
    @user = current_user
    @subjects = @user.subjects
    if params[:at_date].blank?
      case params[:date]
      when 'today'
        @subjects = @subjects.where('created_at > ?', Time.now.at_beginning_of_day)
      when 'weekly'
        @subjects = @subjects.where('created_at > ?', Time.now.at_beginning_of_week)
      when 'monthly'
        @subjects = @subjects.where('created_at > ?', Time.now.at_beginning_of_month)
      else
      end
    else
      @at_date = Date.parse(params[:at_date]).at_beginning_of_day
      @subjects = @subjects.where('created_at < ? and created_at > ?', @at_date.since(1.day), @at_date)
    end
    @subjects = @subjects.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
  end
end