class Customer < ApplicationRecord
  default_scope {where(user_id: Current.user.id)}
  belongs_to :user

end
