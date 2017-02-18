class AddColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :profile_url, :string
  end
end
