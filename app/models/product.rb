class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :order
	validates :name, :price, presence: true
end
