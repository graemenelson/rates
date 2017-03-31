class QueJob < ActiveRecord::Base
  self.primary_keys = :queue, :priority, :run_at, :job_id

  scope :for, -> (job_class) { where(job_class: job_class) }
end
