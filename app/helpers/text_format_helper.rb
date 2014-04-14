# Provides methods to format text to be displayed on the page
# @author Ashley Childress
# @version 3.6.2014
module TextFormatHelper
	
	# Formats the given DateTime object as Monday, day, year at hour:minute am/pm. 
	# For example, 'March 6, 2014 at 10:15am'
	def format_datetime(datetime)
		datetime.strftime('%B %e, %Y at %l:%M %p')
	end
	
	def default_button(btn_glyphicon = nil, btn_size = 'xs', btn_color = 'default', btn_name = nil, link_path)
		glyphicon_text = btn_glyphicon.nil? ? "" : "<span class=\"glyphicon glyphicon-#{btn_glyphicon}\"></span>" unless btn_glyphicon.nil?
		class_value = "btn btn-#{btn_size} btn-#{btn_color}"
		button_text = "#{glyphicon_text}#{btn_name}"
		link_to(button_text.html_safe, link_path, class: class_value)
	end
	
	def default_create_button(button_name = nil, link_path)
		default_button('plus', 'xs', 'info', button_name, link_path)
	end
end