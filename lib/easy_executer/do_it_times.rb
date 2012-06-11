# coding: utf-8
module EasyExecuter
  module DoItTimes
    extend ActiveSupport::Concern

    included do
    end

    private

    def do_it_once(task_title, &block)
      unless Executer.executed_once_a_day_task?(task_title)
        Executer.create_once_a_day_task(task_title)
        yield
      end
    end

    def last_ended_at(opts = {})
      # opts[:type] ||= 'once_a_day_task'
      # if opts[:type] == 'once_a_day_task'
      #   Executer.once_a_day_task_last_ended_at(opts[:task_title])
      # else
      #   nil
      # end
    end

    def had_done_yesterday?(task_title)
      executer = Executer.once_a_day_task_last_ended_at(task_title)
      return false if executer.nil?
      return Time.now - executer.end_time < 24.hours 
    end

    module ClassMethods
      # def do_it_once
      #   p 'it rocks!'
      # end
    end #ClassMethods End

  end
end