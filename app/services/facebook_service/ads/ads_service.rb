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

	def create_ad
		creative_result = create_creative
		creative_id = JSON.parse(creative_result)["id"]

		name = "Kobi"

		HTTParty.post(
		    "https://graph.facebook.com/v2.8/act_#{@ads_account_id}/ads",
		    :query => {
		        :name => "Ad Review by #{name}",
		        :adset_id => "23842558537180529",
		        :creative => '{"creative_id": ' + creative_id + '}',
		        :status => "PAUSED",
		        :access_token => @ads_access_token
		    }
		)

	end

	def create_creative
		name = "Kobi"
		image_url = "http://res.cloudinary.com/dvq8jna9w/image/upload/w_500/c_scale,h_100,l_liron,r_100,w_100,x_-180,y_-20/w_180,h_190,x_-180,y_50,c_fit,l_text:Neucha_16_bold:Liron%20Azrielant/w_280,h_150,x_70,c_fit,l_text:Neucha_26_bold:Bartender%20is%20sooo%20hot%20OMG!%20I%20love%20him%20amazing%20butt!/template_u9xzsf.png"
		
		HTTParty.post(
		    "https://graph.facebook.com/v2.8/act_#{@ads_account_id}/adcreatives",
		    :query => {
		        :name => "ABC",
		        :access_token => @ads_access_token,
		        :image_url => "http://res.cloudinary.com/dvq8jna9w/image/upload/w_500/c_scale,h_100,l_liron,r_100,w_100,x_-180,y_-20/w_180,h_190,x_-180,y_50,c_fit,l_text:Neucha_16_bold:Liron%20Azrielant/w_280,h_150,x_70,c_fit,l_text:Neucha_26_bold:Bartender%20is%20sooo%20hot%20OMG!%20I%20love%20him%20amazing%20butt!/template_u9xzsf.png",
		        :object_story_spec=> '{
    									"page_id": "637312826452988",
    									"instagram_actor_id": "1412439138776563",
									    "link_data": {
									      "link": "http://www.product360blog.com/",
									      "caption": "Task Bar",
									      "description": "Enjoy Task Bar with more people like ' + name + '",
									      "name": "www.product360blog.com",
									      "call_to_action": {
									        "type": "LEARN_MORE"
									      },
									      "picture": "' + image_url + '"
									    }
									  }'
		    }
		)

	end

end
