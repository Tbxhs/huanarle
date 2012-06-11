# coding: utf-8
class StatisticsController < ApplicationController
  layout 'home'
  before_filter :require_login

  def index
    @user = current_user
    today = Time.now.at_beginning_of_day

    ['day', 'week', 'month', 'year'].each do |time|
      begun_at = self.instance_eval("Time.now.at_beginning_of_#{time}")
      self.instance_eval do 
        instance_variable_set("@#{time}_statistics", @user.subjects.where('created_at > ?', begun_at))
        instance_variable_set("@#{time}_total", eval("@#{time}_statistics.to_a.sum(&:total) || 0"))
        count = @user.consumptions.where('created_at > ?', begun_at).count
        instance_variable_set("@#{time}_count", count)
      end
    end

    # @today_statistics = @user.subjects.where('created_at > ?', today)
    # @today_total = @today_statistics.map(&:total).inject(:+)
    # @today_count = @user.consumptions.where('created_at > ?', today).count

    # @week_statistics = @user.subjects.where('created_at > ?', today.at_beginning_of_week)
    # @week_total = @week_statistics.map(&:total).inject(:+)
    # @week_count = @user.consumptions.where('created_at > ?', today.at_beginning_of_week).count

    # @month_statistics = @user.subjects.where('created_at > ?', today.at_beginning_of_month)
    # @month_total = @month_statistics.map(&:total).inject(:+)
    # @month_count = @user.consumptions.where('created_at > ?', today.at_beginning_of_month).count

    # @year_statistics = @user.subjects.where('created_at > ?', today.at_beginning_of_year)
    # @year_total = @year_statistics.map(&:total).inject(:+)
    # @year_count = @user.consumptions.where('created_at > ?', today.at_beginning_of_year).count         
  end
end