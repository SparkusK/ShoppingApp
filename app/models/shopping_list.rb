class ShoppingList
  include Mongoid::Document
  field :household_id, type: Integer
  field :items, type: Array
  field :last_updated, type: DateTime, default: ->{Time.now}

  def add_item(item)
    items.append(Item.new(description: item.name, price: item.price)).save
  end

  def remove_item(item)
  end

end
