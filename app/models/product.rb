class Product < ActiveRecord::Base
  
  default_scope :order => 'title'
  validates :title, :description, :image_url, :presence => true 
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates :image_url, :format => { :with => %r{\.gif|png|jpg}i, :message => 'Must be a URL for GIF,JPG or PNG'} 
end