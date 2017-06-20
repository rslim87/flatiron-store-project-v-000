class Item < ActiveRecord::Base
	belongs_to :category
	has_many :line_items
	has_many :carts, through: :line_items

	def self.available_items
		@available_items = []
		self.all.each do |item|
			if item.inventory >= 1
				@available_items << item
			end
		end
		@available_items
	end

end
