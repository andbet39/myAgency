class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_one :profile
         accepts_nested_attributes_for :profile


   def displayname
     if self.profile.name != "" && self.profile.name != nil
       return self.profile.name + " " +self.profile.surname
     end

     return self.email

   end

end
