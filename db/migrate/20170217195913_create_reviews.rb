class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :fb_id
      t.integer :rating
      t.text :review_text
      t.string :image_url
      t.string :city

      t.timestamps null: false
    end
  end
end
