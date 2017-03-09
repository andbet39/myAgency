class Notification < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :user
end
