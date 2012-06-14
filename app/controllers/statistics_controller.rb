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

  end

  def chart
    @user = current_user
    uncated = @user.consumptions.where('category_id = 0 OR category_id is NULL').sum(&:cost).to_i
    @pie_chart_ary = @user.categories.collect do |category|
      name = category.name
      total = category.consumptions.to_a.sum(&:cost)
      [name, total.to_i]
    end
    @pie_chart_ary ||= []
    @pie_chart_ary = @pie_chart_ary.push(["未分类", uncated]).to_a

    last_time = Time.now.at_beginning_of_month
    first_time = last_time.ago(4.months)
    second_time = last_time.ago(3.months)
    third_time = last_time.ago(2.months)
    fifth_time = last_time.ago(1.months)

    @area_chart_ary = [first_time, second_time, third_time, fifth_time, last_time].collect do |end_time|
      time = "#{end_time.month}月"
      total = @user.subjects
        .where('created_at > ? and created_at < ?', end_time, end_time.since(1.month))
        .sum(&:total)
      [time, total.to_f]
    end.insert(0, ['月份', '消费总额'])
  end

end