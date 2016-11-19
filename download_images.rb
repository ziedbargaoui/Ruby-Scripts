# Script for GetSafe
# Takes a file path as argument and saves all the images that have their
# links in the text file to the hard drive.
# author: Zied Bargaoui

require 'open-uri'
require 'uri'

# Define a new class for custom url operations like fetching an image
class CustomUrl
	def save_image(url)
		if url =~ URI::regexp
			#extract the image filename
			parsed_url 	= URI.parse(url)
			image_name 	= parsed_url.path.split("/").last
			content = open(url).read
			puts 'trying to download: '+url

			# Now save the url's content into a new file
			File.open(image_name, "wb") { 
				|file|  	
				if file.write content
					puts 'Successfully saved '+image_name
					return true
				else
					puts 'saving failed, please make sure the links are correct!'
					return false
				end
			}
		else
			puts 'This is not a valid url: '+url
			return false
		end
	end
end

# we assume the filepath is the first argument
images_file 	=	ARGV[0]
file_content	=	File.read(images_file)
customUrl = CustomUrl.new()
File.foreach(images_file) { 
	|url|
	customUrl.save_image(url)
}

