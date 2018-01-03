class Book < ActiveRecord::Base
  belongs_to :user

  def slug
    title.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|i| i.slug == slug}
  end

end
