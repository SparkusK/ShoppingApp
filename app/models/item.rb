class Item
  include Mongoid::Document
  # field :image, type: BSON::Binary # Image field - not yet implemented
  field :description, type: String
  field :price, type: String # Not sure what to make this yet.
  field :date_captured, type: DateTime, default: ->{Time.now}
  field :search_query, type: String
  field :search_url, type: String
  field :shop, type: String # Will probably change this
end
