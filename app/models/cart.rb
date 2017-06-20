class Cart < ActiveRecord::Base
	belongs_to :user
	has_many :line_items
	has_many :items, through: :line_items

	def total
		total = 0
		@items = self.items		
		@items.each do |item|
			total = total + item.price
		end
		total
	end

	def add_item(item_id)
		line_item = self.line_items.find_by(item_id: item_id)
		if line_item
			line_item.quantity += 1
			line_item.save
		else
			line_item = self.line_items.build(item_id: item_id, quantity: 1)
		end
		line_item
	end

	def checkout
		self.update(status: 'checked out')
		change_inventory
	end

	def change_inventory
		self.line_items.each do |line_item|
			item = Item.find_by(id: line_item.item_id)
			item.update(inventory: item.inventory - line_item.quantity)
		end
	end


end
