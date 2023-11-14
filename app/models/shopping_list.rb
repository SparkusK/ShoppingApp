class ShoppingList
  include Mongoid::Document
  field :household_id, type: Integer
  field :last_updated, type: DateTime, default: ->{Time.now}
  embeds_many :items

  def add_item(item)
    self.items.create!(
      description: item["name"],
      price: item["price"],
      img_url: item["img_url"],
      added_by: item["added_by"]
    )
    Keen.publish(:shopping_items, {household: self.household_id, price: item["price"].to_f})
    UpdateAnalyticsJob.perform_later({household: self.household_id, price: item["price"].to_f})
  end

  def remove_item(item)
    self.items.find_by(_id: item).delete
  end

end
