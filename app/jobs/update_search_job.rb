class UpdateSearchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info("Starting Job")

    searches = Search.where('last_run < ? OR last_run is null', (DateTime.now.utc - 2.hours) )

    searches.each() do |search|
      service  = ListingService.new
      search.last_run = Time.now.utc
      search.save!
      if search.user.ispro
        service.parse_on_pp(search.id)
      end
        service.parse_on_subito(search.id)

        nuovi = SearchResult.where(search_id: search.id).where(is_new: true).count()

        if nuovi > 0
          n = Notification.new
          n.object = search
          n.user_id = search.user_id
          n.body  = "Ci sono " + nuovi.to_s + " nuovi annunci per la tua ricerca"
          n.notified=false
          n.emailed = false
          n.seen = false
          n.save
        end

    end



  end
end
