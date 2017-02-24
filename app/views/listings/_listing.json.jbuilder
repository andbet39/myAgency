json.extract! listing, :id, :title, :link, :tel, :tel2, :email, :description, :insert_date, :mt, :zona, :id_annuncio, :origin, :price,:favourite,:isnew, :created_at, :updated_at
json.url listing_url(listing, format: :json)
