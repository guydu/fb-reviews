class FacebookService::Reviews::ReviewsService

	

	def initialize
		require 'koala'
		page_oauth_access_token = Rails.application.secrets.page_oauth_access_token
		@graph = Koala::Facebook::API.new(page_oauth_access_token)

	end

	def get_reviews
		profile = @graph.get_object("me")
		result = @graph.get_object("me?fields=ratings")

		if !result.nil? && !result["ratings"].nil? && !result["ratings"]["data"].nil?
			result["ratings"]["data"].each do |fb_review|
				name = fb_review["reviewer"]["name"]
				fb_id = fb_review["reviewer"]["id"]
				rating = fb_review["rating"].to_i
				review_text = fb_review["review_text"]
				if Review.where(fb_id: fb_id).empty?
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
