class Interaction < ApplicationRecord
  default_scope {where(user_id: Current.user.id)}
  belongs_to :listing
  belongs_to :user
end
