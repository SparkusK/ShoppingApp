class UpdateAnalyticsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActionCable.server.broadcast 'analytics_channel', {}
  end
end
