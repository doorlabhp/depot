class Product < ActiveRecord::Base
  
  has_many :line_items
  
  default_scope :order => 'title'
  validates :title, :description, :image_url, :presence => true 
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates :image_url, :format => { :with => %r{\.gif|png|jpg}i, :message => 'Must be a URL for GIF,JPG or PNG'}
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
end
