# coding: utf-8
class User < ActiveRecord::Base
  include EasyExecuter::DoItTimes
  
  has_secure_password
  validates_presence_of :email, :login, :message => '不能为空'
  validates_uniqueness_of :email, :login, :message => '已经被注册了'
  validates_length_of :login, :within => 6..20
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  has_many :blogs
  has_many :categories
  has_many :subjects
  has_many :consumptions

  mount_uploader :avatar, AvatarUploader

  def reset_password(orig_password, new_password, new_password_confirmation)
    return [false, '原密码输入错误'] unless self.authenticate(orig_password)
    return [false, '密码至少为6位'] if new_password.length < 6 || new_password.length > 40
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    return [false, '两次输入密码不一致'] unless self.save
    [true, '修改成功']
  end

  def reset_recorded_days
    self.update_attribute(:recorded_days, 0)
  end

  def update_recorded_days
    self.recorded_days += 1
    save!
  end

  def update_recorded_days_after_login
    self.reset_recorded_days unless had_done_yesterday?("#{self.email}_update_recorded_days")
  end

  class << self
    def authenticate(email, password)
      user = User.find_by_email(email)
      if user && user.authenticate(password)
        user.update_attribute(:last_login_at, Time.now)
        user
      else
        nil
      end
    end

    # Get current user in model.
    # def current
    #   Thread.current[:current_user]
    # end

    # def current=(user)
    #   Thread.current[:current_user] = user
    # end
  end
end