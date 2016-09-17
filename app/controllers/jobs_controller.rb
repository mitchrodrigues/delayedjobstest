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

  def reset
    Delayed::Job.delete_all # Delete all jobs in the table.
    redirect_to action: :index
  end


  def queue
    Delayed::Job.enqueue(
       payload_object: job_constant.new, 
       queue: params[:queue], # So this is so we can support multiple Q's
       priority: job_priority # This is the magic, since we have workers listening
                              # to multiple Q's make them respect priority as well 0 
                              # being the highest here
    )

    redirect_to action: :index
  end


  private 

  def job_constant
    "#{params[:job].camelize}Job".constantize # Gross
  end

  # Easiest way to turn queue into priority for this purposes
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