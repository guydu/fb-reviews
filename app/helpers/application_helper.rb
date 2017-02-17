module ApplicationHelper

	def chosen_controller
		return params[:controller]
	end

	def should_choose controller_name
		return (chosen_controller == controller_name)
	end

end
