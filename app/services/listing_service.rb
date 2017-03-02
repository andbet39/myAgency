class ListingService
  def parse(search_id)

    search = Search.find(search_id)

    require 'open-uri'
    url = "http://www.subito.it/annunci-lazio/vendita/appartamenti/"+search.zone.subitourl+"&f=p"
    Rails.logger.info(url)
    docmain = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    paginator_link  = docmain.css('.number_container>div>a')
    #parso la prima pagina
    parse_page(url,search)

    
    paginator_link.each() do |link|
        page =  Nokogiri::HTML(open('http://www.subito.it/'+ link['href'], {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
        parse_page('http://www.subito.it/'+link['href'],search)
    end
  end



  def parse_page(url,search)
    doc = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    annunci = doc.css('.item_list_inner')

    annunci.each do |annuncio|

      telefono = "0"
      mq="0"
      prezzo="0"
      link_annuncio = annuncio.css('h2>a')[0]['href']
      titolo = annuncio.css('h2>a')[0].text

      pagina_annuncio = Nokogiri::HTML(open('http://www.subito.it/'+ link_annuncio, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
      id_annuncio = pagina_annuncio.css('#listid')[0].text
      data_annuncio = pagina_annuncio.css('time')[0]['datetime']

      listing = nil
      old_annuncio = Listing.where(id_annuncio: id_annuncio).where(:user_id => search.user.id).first
      if  old_annuncio != nil
          listing = old_annuncio
          listing.isnew = false
          Rails.logger.info('Update annuncio : '+ id_annuncio)

      else
          listing = Listing.new()
          listing.isnew  = true
          Rails.logger.info('New annuncio : '+  id_annuncio)
          listing.insert_date = data_annuncio
          listing.user = search.user
      end

      if pagina_annuncio.css('td.details_value')[4] != nil
          mq = pagina_annuncio.css('td.details_value')[4].text
      end

      if   pagina_annuncio.css('.price')[0] != nil
            prezzo =  pagina_annuncio.css('.price')[0].text
      end

      descrizione  = pagina_annuncio.css('.description')[0].text


        if  pagina_annuncio.css('#adv_phone_full')[0] != nil
            telefono  =  pagina_annuncio.css('#adv_phone_full')[0].text
        end

        listing.price = prezzo.strip.delete('.').delete('€')
        listing.title = titolo
        listing.link  = link_annuncio
        listing.tel =telefono
        listing.id_annuncio = id_annuncio
        listing.mt  = mq
        listing.description = descrizione
        listing.origin  = 'Subito'

        listing.save!

        if  old_annuncio == nil
            search.search_results.create(listing:listing)
        end

    end
  end
end
