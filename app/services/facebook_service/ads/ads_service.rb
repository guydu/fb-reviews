class FacebookService::Ads::AdsService

	

	def initialize
		@ads_account_id = "10154464981709480"
		@ads_access_token = Rails.application.secrets.ads_access_token

	end

	def get_ads
		HTTParty.get(
		    "https://graph.facebook.com/v2.8/act_#{@ads_account_id}/ads",
		    :query => {
		        :fields => "name",
		        :access_token => @ads_access_token
		    }
		)
	end

	def create_ad review
		creative_result = create_creative review
		creative_id = JSON.parse(creative_result)["id"]

		HTTParty.post(
		    "https://graph.facebook.com/v2.8/act_#{@ads_account_id}/ads",
		    :query => {
		        :name => "Ad Review by #{review.name}",
		        :adset_id => "23842558537180529",
		        :creative => '{"creative_id": ' + creative_id + '}',
		        :status => "PAUSED",
		        :access_token => @ads_access_token
		    }
		)

		review.update(published_ad: true)

	end

	def create_creative review

		HTTParty.post(
		    "https://graph.facebook.com/v2.8/act_#{@ads_account_id}/adcreatives",
		    :query => {
		        :name => "ABC",
		        :access_token => @ads_access_token,
		        :image_url => "#{review.review_image_url}",
		        :object_story_spec=> '{
    									"page_id": "637312826452988",
    									"instagram_actor_id": "1412439138776563",
									    "link_data": {
									      "link": "http://www.product360blog.com/",
									      "caption": "Task Bar",
									      "description": "Enjoy Task Bar with more people like ' + review.name + '",
									      "name": "www.product360blog.com",
									      "call_to_action": {
									        "type": "LEARN_MORE"
									      },
									      "picture": "' + review.review_image_url + '"
									    }
									  }'
		    }
		)

	end

end
