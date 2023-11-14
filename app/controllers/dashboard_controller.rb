class DashboardController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def dashboard
  end

  def get_total_items_price
    total = 0
    ShoppingList.all.each do |list|
      list.items.each do |item|
        total += item.price.to_f
      end
    end
    respond_to do |format|
      format.json {
        render json: { result: total.round(2) }
      }
      format.html {
        render json: { result: total.round(2) }
      }
    end
  end

  def get_avg_items_price
    total = 0
    ShoppingList.all.each do |list|
      list.items.each do |item|
        total += item.price.to_f
      end
    end
    respond_to do |format|
      format.json {
        render json: { result: total.round(2) }
      }
      format.html {
        render json: { result: total.round(2) }
      }
    end
  end

  def get_total_items
    total = 0
    ShoppingList.all.each do |list|
      list.items.each do |item|
        total += item.price.to_f
      end
    end
    respond_to do |format|
      format.json {
        render json: { result: total.round(2) }
      }
      format.html {
        render json: { result: total.round(2) }
      }
    end
  end

  def get_user_amount
    respond_to do |format|
      format.json {
        render json: { result: User.count }
      }
      format.html {
        render json: { result: User.count }
      }
    end
  end

  def get_sorted_items_by_price

    items = []

    ShoppingList.all.each{ |list| items += list.items }
    prices = items.map{ |item| item.price.to_f.round(2) }.sort.reverse[0..10]
    respond_to do |format|
      format.json {
        render json: { result: prices }
      }
      format.html {
        render json: { result: prices }
      }
    end
  end

  def get_grouped_items

    items_counts = []

    items = []
    ShoppingList.all.each{ |list| items += list.items }
    grouped_items = items.group_by { |item| item.description }
    grouped_items.each {|item| items_counts += [{name: item[0], count: item[1].size}] }
    items_counts.sort_by! {|hsh| hsh[:counts]}.reverse
    respond_to do |format|
      format.json {
        render json: { result: items_counts }
      }
      format.html {
        render json: { result: items_counts }
      }
    end
  end



end
