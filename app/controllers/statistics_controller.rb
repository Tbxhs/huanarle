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
    uncated = @user.consumptions.where(:category_id => 0).sum(&:cost).to_i
    @chart_ary = @user.categories.collect do |category|
      name = category.name
      total = category.consumptions.to_a.sum(&:cost)
      [name, total.to_i]
    end.push(["未分类", uncated]).to_a


  end

  def chart
    @user = current_user
    respond_to do |format|
      format.html {
        @chart_ary = @user.categories.collect do |category|
          name = category.name
          total = category.consumptions.to_a.sum(&:cost)
          [name, total.to_i]
        end.to_a
      }
    end


  end

end