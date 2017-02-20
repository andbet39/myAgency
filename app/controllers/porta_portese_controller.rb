class Annuncio
   def initialize(title, link, price)
     @title = title
     @link = link
     @price = price
   end
   attr_reader :title
   attr_reader :link
 end
#http://www.portaportese.it/rubriche/Immobiliare/Ville_e_appartamenti_(Roma)/Monteverde-Gianicolo/m-no-agenzie-keyWno+agenzie?to=ordinaADis&zoomstart=10&latstart=41.8966&lngstart=12.494
#http://www.portaportese.it/rubriche/Immobiliare/Ville_e_appartamenti_(Roma)/Prati-Borgo-Mazzini/m-no-agenzia-keyWno+agenzia?to=ordinaADis&zoomstart=14&latstart=41.91036&lngstart=12.45542
#http://www.portaportese.it/rubriche/Immobiliare/Ville_e_appartamenti_(Roma)/Prati-Borgo-Mazzini/m-no-Agenzia-keyWno-Agenzia
class PortaPorteseController < ApplicationController


  def index

  end

  def run_search

    search = Search.find(params['search_id'])

    require 'open-uri'
    url = "http://www.portaportese.it/rubriche/Immobiliare/Ville_e_appartamenti_(Roma)/"+search.zona+"/m-"+search.keyword.downcase.tr(' ','-')+"-keyW"+search.keyword.downcase.tr(' ','+')
    logger.info(url)

    parsepage(url,search.id)

    docmain = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    pagine = docmain.css('.page-link')
    pagine.each do |pagina|
      link_pagina = "http://www.portaportese.it"+pagina['href']
      parsepage(link_pagina,search.id)
    end #pagine
    redirect_back(fallback_location: searches_path)
  end


  def parsepage (url,search_id)
    doc = Nokogiri::HTML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    annunci = doc.css('.risultato')
    annunci.each do |annuncio|

      old_annuncio = Listing.where(id_annuncio: annuncio['name']).first
      if  old_annuncio != nil
          listing = old_annuncio
          logger.info('Update annuncio : '+  annuncio['name'])
      else
          listing = Listing.new()
          logger.info('New annuncio : '+  annuncio['name'])
          listing.insert_date = Time.now
      end

      title  = annuncio.css('h2.ris-title>a').text
      link = annuncio.css('h2.ris-title>a')[0]['href']

      pagina_annuncio = Nokogiri::HTML(open("http://www.portaportese.it" + link, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

      listing.title = title
      listing.link  = "http://www.portaportese.it"+link
      listing.id_annuncio = annuncio['name']
      price = annuncio.css('.attr-prezzo').text.delete('€').delete(' ').delete('.')
      listing.price = price
      listing.mt  = annuncio.css('.attr-mq').text
      listing.description = pagina_annuncio.css('p.ins-testo').text
      listing.origin  = 'PP'

      if  pagina_annuncio.css('li.mail>a')[0] != nil
          listing.email = pagina_annuncio.css('li.mail>a')[0]['data-contact'].delete(' ')
      end
      if  pagina_annuncio.css('li.tel>a')[0] != nil
        listing.tel = pagina_annuncio.css('li.tel>a')[0]['data-contact'].delete(' ')
        if pagina_annuncio.css('li.tel>a').length >1
          listing.tel2 = pagina_annuncio.css('li.tel>a')[1]['data-contact'].delete(' ')
        end

        listing.save
      end

      #Se nuovo creo anche il search result
      if  old_annuncio == nil
          search = Search.find(search_id)
          search.search_results.create(listing:listing)
      end

    end #annunci
  end
end
