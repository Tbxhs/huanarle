# coding: utf-8
class Memo < ActiveRecord::Base
  belongs_to :user
  validates_length_of :content, :maximum => 300, :minimum => 1
end