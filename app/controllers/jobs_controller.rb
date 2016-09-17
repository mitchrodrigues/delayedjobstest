class JobsController < ApplicationController
  def index
    jobs = Delayed::Job.all

    # this is ugly but its just for show
    @job_list = {}
    jobs.each do |job|
      @job_list[job.queue] ||= []
      @job_list[job.queue] << job
    end
  end

  def queue
    Delayed::Job.enqueue(
       payload_object: job_constant.new, 
       queue: params[:queue],
       priority: job_priority
    )
    return redirect_to action: :index
  end


  private 

  def job_constant
    "#{params[:job].camelize}Job".constantize # Gross
  end

  def job_priority
    case params[:queue]
      when 'high'
        0
      when 'medium'
        1
      when 'low'
        2
    end
  end
end