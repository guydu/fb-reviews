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

    reviews_service = FacebookService::Reviews::ReviewsService.new
    
    reviews_service.get_reviews

  end


end
