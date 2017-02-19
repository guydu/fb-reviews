class FacebookService::Reviews::ReviewsService

	

	def initialize
		require 'koala'
		page_oauth_access_token = Rails.application.secrets.page_oauth_access_token
		@graph = Koala::Facebook::API.new(page_oauth_access_token)

	end

	def get_reviews
		Rails.logger.error "101"
		profile = @graph.get_object("me")
		Rails.logger.error "102"
		result = @graph.get_object("me?fields=ratings")
		Rails.logger.error "103"

		if !result.nil? && !result["ratings"].nil? && !result["ratings"]["data"].nil?
			Rails.logger.error "104"
			result["ratings"]["data"].each do |fb_review|
				Rails.logger.error "105"
				name = fb_review["reviewer"]["name"]
				fb_id = fb_review["reviewer"]["id"]
				rating = fb_review["rating"].to_i
				review_text = fb_review["review_text"]
				Rails.logger.error "106"
				if Review.where(fb_id: fb_id).empty?
					Rails.logger.error "107"
					review = Review.create(name: name,
										fb_id: fb_id,
										rating: rating,
										review_text: review_text)
				end

			end
		end
	rescue => e
  		Rails.logger.error e.message
  		Rails.logger.error e.backtrace.join("\n")

	end

end
