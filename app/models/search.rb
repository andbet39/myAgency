class Search < ApplicationRecord
  has_many :search_results
  has_many :listings, through: :search_results
  belongs_to :user
  belongs_to :zone

end
