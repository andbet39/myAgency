class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_one :profile
         has_many :notifications
         accepts_nested_attributes_for :profile


   def displayname
     if self.profile.name != "" && self.profile.name != nil
       return self.profile.name + " " +self.profile.surname
     end

     return self.email

   end

   def notification_to_read
     self.notifications.where(seen:false)
   end

   def ispro
     if self.pro_end_date != nil
        if self.pro_end_date > Time.now
          return true
        else
          return false
        end
      else
        return false
      end
   end

end
