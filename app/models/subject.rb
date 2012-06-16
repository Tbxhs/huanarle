# coding: utf-8
class Subject < ActiveRecord::Base
  include EasyExecuter::DoItTimes

  # TODO:
  # 现在的主题改为以天为计算，每天就算一个主题，新建的消费都聚合到当天的那个主题中
  # 这样用户可以无需再填写主题 
  validates_presence_of :title

  belongs_to :user, :counter_cache => true
  has_many :consumptions, :dependent => :destroy

  delegate :email, :to => :user, :prefix => true

  after_create :set_user_recorded_days
  # after_destroy :set_user_recorded_days

  def self.find_or_create_by_user_id_and_datetime(user_id, datetime)
    datetime = datetime.to_datetime if datetime.is_a?(String)
    datetime = datetime.at_beginning_of_day
    subject = Subject.where(:user_id => user_id, :created_at => datetime).first
    if subject.nil?
      subject = Subject.create :title          =>   "#{datetime.strftime('%F')} 消费记录",
                               :user_id        =>   user_id,
                               :created_at     =>   datetime
    end
    subject 
  end

  private

  def set_user_recorded_days
    do_it_once("#{self.user_email}_update_recorded_days") do
      self.user.reset_recorded_days unless had_done_yesterday?("#{self.user_email}_update_recorded_days")
      self.user.update_recorded_days
    end
  end

end