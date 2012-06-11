# coding: utf-8
class Subject < ActiveRecord::Base
  include EasyExecuter::DoItTimes

  belongs_to :user, :counter_cache => true
  validates_presence_of :title
  has_many :consumptions, :dependent => :destroy
  delegate :email, :to => :user, :prefix => true

  after_create :set_user_recorded_days
  # after_destroy :set_user_recorded_days

  private
  def set_user_recorded_days
    do_it_once("#{self.user_email}_update_recorded_days") do
      self.user.reset_recorded_days unless had_done_yesterday?("#{self.user_email}_update_recorded_days")
      self.user.update_recorded_days
    end
  end

end