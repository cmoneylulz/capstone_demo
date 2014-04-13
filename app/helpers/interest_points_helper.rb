# Defines methods to use in +Interest Point+ views to help DRY resources
# @author Ashley Childress
# @version 3.8.2014
module InterestPointsHelper
	
	# Create a link to display on the page that, when clicked, will append a new section identified by the given +partial+ that should be used to create a new nested object for the calling view object.
	# @param [String] name text that should be displayed for the corresponding link when displayed on the page
	# @param [FormBuilder] f the +form_for+ object that should be passed to the +partial+ view when created
	# @param [Symbol] association the type of object that is handled by the corresponding +partial+
	# @param [String] partial the relative path of the +partial+ view that should be appened after the corresponding link is clicked
	# @returns link_to a link to append the given +partial+ view to the existing page in order to create a new object, identified by the given +association+
	def link_to_add_fields(name, f, association, partial)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial, f: builder)
    end
    link_to(name, '', class: "add_fields btn btn-success btn-xs", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  # Get the title that should be displayed on the page for the Interest Point.
  # @pre +interest_point+ must be a valid +Interest Point+ record in this application
  # @param [InterestPoint] interest_point the object to create a new header for
  # @returns [String] text that should be displayed at the top of any +Interest Point+ page for the given +interest_point+ object.
  def page_header(interest_point)
  	#TODO:
  end
end