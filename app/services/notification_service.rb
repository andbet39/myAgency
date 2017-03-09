class NotificationService
  def self.clear_search_notification(search_id)

    Notification.where(seen: false,object_type: 'Search',object_id: search_id).update_all(seen: true)

  end
end
