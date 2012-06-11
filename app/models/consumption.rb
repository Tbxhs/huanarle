# coding: utf-8
class Consumption < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :subject, :counter_cache => true
  validates_presence_of :title, :cost
  # attr_accessible :user_id, :subject_id

  before_save :update_subject_total_cost
  def update_subject_total_cost
    subject.total += self.cost
    subject.save
  end
  
end