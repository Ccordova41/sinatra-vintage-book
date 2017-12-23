class User < ActiveRecord::Base
   has_many :books
   has_secure_password

   def slug
     username.downcase.gsub(" ", "-")
   end

   def self.find_by_slug(slug)
     self.all.find{|i| i.slug == slug}
   end

end
