# coding: utf-8
class FeedBack < ActiveRecord::Base
  validates_length_of :content, :within => 1..500
  belongs_to :user
end