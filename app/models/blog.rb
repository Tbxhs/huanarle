# coding: utf-8
class Blog < ActiveRecord::Base
  belongs_to :user
  validates_length_of :title, :maximum => 80, :minimum => 0


end