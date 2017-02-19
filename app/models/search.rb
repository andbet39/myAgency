class Search < ApplicationRecord
  has_many :search_results
  has_many :listings, through: :search_results
end
