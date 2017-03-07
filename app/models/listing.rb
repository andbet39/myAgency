class Listing < ApplicationRecord
  acts_as_votable
  has_many :search_results
  has_many :searches, through: :search_results
  has_many :interactions
  belongs_to :user

  def pricemq
    p=0
    if self.price != nil && self.mt != nil && self.price != ""  && self.mt != "" && self.mt !=0
      p = Integer(self.price)/Integer(self.mt)
    end
      return p
  end


end
