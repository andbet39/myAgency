class Interaction < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  belongs_to :customer
  default_scope {where(user_id: Current.user.id)}
  accepts_nested_attributes_for :customer

end
