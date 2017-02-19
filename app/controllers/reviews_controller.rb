class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def index
    @reviews = Review.all

    # @text1 = URI.escape("great bar! enjoyed it very much! the vibe and the music are amazing")
    # @name1 = URI.escape("Guy Dubrovski")
    # @image_id1 = URI.escape("guy")

    # @text2 = URI.escape("Bartender is sooo hot OMG! I love him, amazing butt!")
    # @text2.gsub!(',', '')

    # @name2 = URI.escape("Liron Azrielant")
    # @image_id2 = URI.escape("liron")
  end

  def refresh
    console.log("1");
    reviews_service = FacebookService::Reviews::ReviewsService.new
    console.log("100");
    reviews_service.get_reviews
    console.log("200");
    redirect_to :authenticated_root

  end

  def create_ad
    review_id = params["review_id"]
    review = Review.find(review_id)
    ads_service = FacebookService::Ads::AdsService.new
    ads_service.create_ad review

    redirect_to :authenticated_root
  end


end
