class Listing < ApplicationRecord
  acts_as_votable
  has_many :search_results
  has_many :searches, through: :search_results
  has_many :interactions
  belongs_to :user

end
