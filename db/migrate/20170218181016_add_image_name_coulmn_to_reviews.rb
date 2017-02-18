class AddImageNameCoulmnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :image_name, :string
  end
end
