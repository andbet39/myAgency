class Profile < ApplicationRecord
  default_scope {where(user_id: Current.user.id)}

  has_one :user
end
