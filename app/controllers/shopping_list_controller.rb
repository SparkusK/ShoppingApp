class ShoppingListController < ApplicationController

  def search_item
    # Search the query on the PNP store, download the page, parse the results into an array of {:name=>"", :price=>x.y} hashes:
    if params[:query].present?
      # Use string interpolation to inject the search parameter into the PNP site search url,
      # open-uri to download the page (at the url),
      # and Nokogiri to parse the downloaded page into a Nokogiri object/document
      nokodoc = Nokogiri::HTML(open("https://www.pnp.co.za/pnpstorefront/pnp/en/search/?pageSize=36&sort=relevance&q=#{params[:query].split.join('+')}%3Arelevance&show=Page#"))
      # Use xpath to get all the nodes of interest in the Nokogiri object/document
      nodes = nokodoc.xpath('//ul[@class="product-listing product-grid row"]/div[@class="productCarouselItemContainer"]/div[@class="productCarouselItem js-product-carousel-item"]/div[@class="item js-product-card-item"]/a')
      # Iterate through all these nodes, parsing from them the required name and price fields.
      # This will create an array with name=>"", price=>x.y hashes ([{name: "", price: x.y}, {name: "", price: x.y},  etc])
      @items = nodes.map { |node|
        rands_raw = node.children[5].children[1].children[1].children[0].content
        cents_raw = node.children[5].children[1].children[1].children[1].children[0].content
        name_raw = node.children[3].children[0].content
        Hash({
            name: name_raw,
            price: (rands_raw[rands_raw.index('R')+1..-1] + "." + cents_raw).to_f,
            img_url: node.children[1].children[1].attributes["src"].value
        })
      }
      if !@items.empty?
        params[:items] = @items
        flash[:success] = "Successfully found #{@items.size} items with the query #{params[:query]}."
        render 'select_items', collection: @items
      else
        flash[:warning] = "Nothing went wrong, but the query didn't return any items. Please try again with a different query."
        redirect_to root_path
      end
    else
      flash[:error] = "No input query was found. Please try again with a valid search query."
      redirect_to root_path
    end
  end

  def remove_items
    @shoppinglist = ShoppingList.find_by(household_id: current_user.household.id)
    items = params["items"].map{ |item| YAML.load(item) }
    items.each{ |item| @shoppinglist.remove_item(item)}
    flash[:success] = "Successfully removed the items"
    redirect_to root_path
  end

  def add_items
    @shoppinglist = ShoppingList.find_by(household_id: current_user.household.id)
    items = params["items"].map{ |item| YAML.load(item) }
    items.each {|item| @shoppinglist.add_item(item)}
    flash[:success] = "Successfully added the items"
    redirect_to root_path
  end

  def create_shopping_list(household_id)
    ShoppingList.new(household_id: household_id, items: []).save!
  end

  def select_items
    render 'shopping_lists/select_items'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def shopping_list_params
    params.require({:items=>[]}).permit(:household_id, {:indexes=>[]})
  end
end
