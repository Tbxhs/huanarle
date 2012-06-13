# coding: utf-8
class Category < ActiveRecord::Base
  belongs_to :user
  has_many :consumptions, :dependent => :destroy

  validates_uniqueness_of :name, :scope => :user_id, :message => '已经添加过这个分类了'
  validates_length_of :name, :within => 2..10

end