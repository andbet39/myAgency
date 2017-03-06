class ListingService

  def parse_on_subito(search_id)
    search = Search.find(search_id)
    require 'open-uri'
    url = "http://www.subito.it/annunci-lazio/vendita/appartamenti/"+search.zone.subitourl+"&f=p&q="+search.keyword.tr(" ", "+")
    Rails.logger.info(url)
    begin
    docmain = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    paginator_link  = docmain.css('.number_container>div>a')
    #parso la prima pagina
    parse_page_subito(url,search)
    paginator_link.each() do |link|
        page =  Nokogiri::HTML(open('http://www.subito.it/'+ link['href'], {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
        parse_page_subito('http://www.subito.it/'+link['href'],search)
    end
    rescue OpenURI::HTTPError => the_error
      the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
      puts "Whoops got a bad status code #{the_error.message}"
    end
  end



  def parse_page_subito(url,search)
    begin
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

      if pagina_annuncio.css('td.details_value')[4] != nil
          mq = pagina_annuncio.css('td.details_value')[4].text
      end

      if   pagina_annuncio.css('.price')[0] != nil
            prezzo =  pagina_annuncio.css('.price')[0].text
      end
      if  pagina_annuncio.css('#adv_phone_full')[0] != nil
          telefono  =  pagina_annuncio.css('#adv_phone_full')[0].text
      end

      descrizione  = pagina_annuncio.css('.description')[0].text

      add_listing(search,id_annuncio,data_annuncio,titolo,descrizione,prezzo,mq,telefono,"","","Subito.it",link_annuncio)

    end
    rescue OpenURI::HTTPError => the_error
      the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
      puts "Whoops got a bad status code #{the_error.message}"
    end
  end

  def parse_on_pp(search_id)

    search = Search.find(search_id)
    require 'open-uri'
    url = "http://www.portaportese.it/rubriche/Immobiliare/Ville_e_appartamenti_(Roma)/"+search.zone.pp_url_part+"/m-"+search.keyword.downcase.tr(' ','-')+"-keyW"+search.keyword.downcase.tr(' ','+')
    Rails.logger.info(url)
    parse_page_pp(url,search)

    begin
      docmain = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
      pagine = docmain.css('.page-link')
      pagine.each do |pagina|
        link_pagina = "http://www.portaportese.it"+pagina['href']
        parse_page_pp(link_pagina,search)
      end #pagine
    rescue OpenURI::HTTPError => the_error
      the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
      puts "Whoops got a bad status code #{the_error.message}"
    end


  end


  def parse_page_pp (url,search)
      begin
        doc = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

        annunci = doc.css('.risultato')
        annunci.each do |annuncio|

          title  = annuncio.css('h2.ris-title>a').text
          link = annuncio.css('h2.ris-title>a')[0]['href']
          tel=""
          tel2=""
          email=""
          pagina_annuncio = Nokogiri::HTML(open("http://www.portaportese.it" + link, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))


          link  = "http://www.portaportese.it"+link
          id_annuncio = annuncio['name']
          price = annuncio.css('.attr-prezzo').text.delete('€').delete(' ').delete('.')

          mt  = annuncio.css('.attr-mq').text
          description = pagina_annuncio.css('p.ins-testo').text
          origin  = 'PP'

          if  pagina_annuncio.css('li.mail>a')[0] != nil
              email = pagina_annuncio.css('li.mail>a')[0]['data-contact'].delete(' ')
          end
          if  pagina_annuncio.css('li.tel>a')[0] != nil
            tel = pagina_annuncio.css('li.tel>a')[0]['data-contact'].delete(' ')
            if pagina_annuncio.css('li.tel>a').length >1
              tel2 = pagina_annuncio.css('li.tel>a')[1]['data-contact'].delete(' ')
            end
          end

          add_listing(search,id_annuncio,Time.now,title,description,price,mt,tel,tel2,email,"PortaPortese",link)
        end #annunci
      rescue OpenURI::HTTPError => the_error
        the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
        puts "Whoops got a bad status code #{the_error.message}"
      end

  end



  def add_listing(search,listing_id,listing_date,title,description,price,mq,tel,tel2,email,origin,link)


    listing = Listing.where(id_annuncio: listing_id).first
    if  listing == nil
        listing = Listing.new
        listing.isnew = true
    end

    listing.price = price.delete('€').delete(' ').delete('.')
    listing.title = title
    listing.link  = link
    listing.tel =tel
    listing.tel2 =tel2
    listing.email = email
    listing.id_annuncio = listing_id

    int_mt=0
    if mq != "" && mq != nil
      int_mt = Integer(mq.delete('mq').strip)
    end
    listing.mt  = int_mt
    listing.insert_date = listing_date
    listing.description = description
    listing.origin  = origin

    listing.save

    sr  =  SearchResult.where(:listing_id => listing.id).where(:search_id => search.id).first
    if sr == nil
        s = SearchResult.new
        s.listing=listing
        s.search=search
        s.is_new = true
        s.save!
    else
        sr.is_new=false
        sr.save!
    end

  end




end
