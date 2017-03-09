class NotificationController < ApplicationController
  def view
      notification = Notification.find(params['notification_id'])
      notification.seen = true
      notification.save
      if notification.object_type =="Search"
        redirect_to results_path( search_id: notification.object_id)
      end
  end
end
