json.extract! customer, :id, :name, :surname, :phone1, :phone2, :address, :email, :created_at, :updated_at
json.url customer_url(customer, format: :json)