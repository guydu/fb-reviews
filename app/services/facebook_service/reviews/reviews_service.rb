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

				if Review.find(fb_id: fb_id).nil?
					review = Review.create(name: name,
										fb_id: fb_id,
										rating: rating,
										review_text: review_text)
				end

			end
		end



		

		
		# friends = @graph.get_connections("me", "friends")
		# @graph.put_connections("me", "feed", message: "I am writing on my wall!")

		# # Three-part queries are easy too!
		# @graph.get_connections("me", "mutualfriends/#{friend_id}")

		# # You can use the Timeline API:
		# # (see https://developers.facebook.com/docs/beta/opengraph/tutorial/)
		# @graph.put_connections("me", "namespace:action", object: object_url)

		# # For extra security (recommended), you can provide an appsecret parameter,
		# # tying your access tokens to your app secret.
		# # (See https://developers.facebook.com/docs/reference/api/securing-graph-api/
		# # You'll need to turn on 'Require proof on all calls' in the advanced section
		# # of your app's settings when doing this.
		# @graph = Koala::Facebook::API.new(oauth_access_token, app_secret)

	end

end
