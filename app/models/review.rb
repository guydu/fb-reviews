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
					break
				end

				review_element = review_element.next_element
			end
		end
	end
end
