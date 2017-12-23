class User < ActiveRecord::Base
   has_many :books
   has_secure_password

   validates :username, :email, presence: true
   validates :username, :email, uniqueness: true
   validates :password, length: {minimum: 9}
   # validates_email_format_of :email

   def slug
     username.downcase.gsub(" ", "-")
   end

   def self.find_by_slug(slug)
     self.all.find{|i| i.slug == slug}
   end

end
