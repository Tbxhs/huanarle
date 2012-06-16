# coding: utf-8
class MemosController < ApplicationController
  before_filter :require_login

  def update
    user = current_user
    memo = user.memos.last || user.memos.build
    memo.content = params[:content]
    respond_to do |format|
      format.js { render_to_json(:success => memo.save) }
    end
  end
  
end