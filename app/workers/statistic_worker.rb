# frozen_string_literal: true
class StatisticWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
