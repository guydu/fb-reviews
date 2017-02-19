class Review < ActiveRecord::Base

	after_create :scrape_reviewer

	def scrape_reviewer
		if self.scraped
			return
		end

		page_url = "https://www.facebook.com/Task-Bar-637312826452988/"

		require 'open-uri'
		require 'nokogiri'
		doc = Nokogiri::HTML(open(page_url))

		review_composer_container = doc.at_css("div#review_composer_container")
		if !review_composer_container.nil?
			review_element = review_composer_container.next_element

			while (!review_element.nil? && !review_element.attribute("id").nil?)
				small_image = review_element.at_css("img").attribute("src").value
				profile_url = review_element.at_css("a").attribute("href").value

				name = review_element.children[1].children[0].text

				if (self.name == name && self.image_url.nil?)
					self.image_url = small_image
					self.profile_url = profile_url
					self.scraped = true
					self.save

					Cloudinary::Uploader.upload(self.image_url, :public_id => self.image_name)

					break
				end

				review_element = review_element.next_element
			end
		end
	end

	def escaped_text
		clean_url = URI.escape(self.review_text).gsub(',', '')
		clean_url = URI.escape(clean_url).gsub('.', '')
		clean_url = URI.escape(clean_url).gsub("'", '')
		return URI.escape(self.review_text).gsub(',', '')
	end

	def escaped_name
		return URI.escape(self.name)
	end

	def image_name
		return "profile_" + self.fb_id
	end

	def review_image_url
		text_transform = "w_280,h_150,x_70,c_fit,l_text:Neucha_26_bold:#{self.escaped_text}"
        name_transform = "w_180,h_190,x_-180,y_50,c_fit,l_text:Neucha_16_bold:#{self.escaped_name}"
        if (image_url.nil?)
        	# image scraping failed - we choose randomly between 3 random bar images
        	rand = Random.new
        	image_id = rand.rand(1..3)
        	image_name = "bar#{image_id}"
        	image_transform = "h_100,l_#{image_name},c_fill,r_100,w_100,x_-180,y_-20"
		else
			image_transform = "c_scale,h_100,l_#{self.image_name},r_100,w_100,x_-180,y_-20"
		end

		return "http://res.cloudinary.com/dvq8jna9w/image/upload/w_500/#{image_transform}/#{name_transform}/#{text_transform}/template_u9xzsf.png"
	end

end
