class AddBoolColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :scraped, :boolean
    add_column :reviews, :published_ad, :boolean
  end
end
