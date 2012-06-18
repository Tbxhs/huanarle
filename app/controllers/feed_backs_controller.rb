# coding: utf-8
class FeedBacksController < ApplicationController
  before_filter :require_login

  def create
    current_user.feed_backs.create(:content => params[:content])
    render_to_json(:success => true)
  end

end