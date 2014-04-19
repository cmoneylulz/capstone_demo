require 'test_helper'

# Defines tests for the ImageUploader used to store specific files for an Image
# @author Ashley Childress
# @version 3.5.2014
describe ImageUploader do
	
	before do
		ImageUploader.enable_processing = true
		@image = Factory.create(:image)
		@uploader = ImageUploader.new(@image)
	end
	
	after do
		ImageUploader.enable_processing = false
		@uploader.remove!
	end
	
	## Test processing features for uploadere here; not yet implemented
	
end
