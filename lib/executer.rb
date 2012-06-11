# coding: utf-8

class Executer < ActiveRecord::Base
  class << self

    def executed_once_a_day_task?(task_title)
      today = Time.now.at_beginning_of_day
      Executer.where(:task_title => task_title).where('start_time > ?', today).count > 0
    end

    def create_once_a_day_task(task_title) 
      # task_title must be unique.
      # e.g: task_title = user_name_task_title.
      start_time = Time.now
      end_time = Time.now.end_of_day
      Executer.create :task_title       =>      task_title,
                      :start_time       =>      start_time,
                      :end_time         =>      end_time,
                      :do_times         =>      1,
                      :done_times       =>      1
    end

    def once_a_day_task_last_ended_at(task_title)
      Executer.where(:task_title => task_title).order('end_time DESC').first
    end

  end
end