# coding: utf-8

class CategoriesController < ApplicationController
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
end