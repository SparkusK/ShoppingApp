class ShoppingList
  include Mongoid::Document
  field :household_id, type: Integer
  field :last_updated, type: DateTime, default: ->{Time.now}
  embeds_many :items

  def add_item(item)
    self.items.create!(description: item["name"], price: item["price"], img_url: item["img_url"])
  end

  def remove_item(item)
  end

end
