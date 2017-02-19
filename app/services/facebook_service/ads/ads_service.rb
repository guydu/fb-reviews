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

end
