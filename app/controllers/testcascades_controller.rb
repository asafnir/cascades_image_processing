# include OpenCV

class TestcascadesController < ApplicationController
	def index
		@classifier = Dir["lib/classifier/*.xml"].map {|x| x.split("/")[2]}
	end

	def upload_photo
        name =  params[:test][:datafile].original_filename
        cascades = params[:test][:classifier]
        directory = "public/data" # specify yr own path in public folder
        # create the file path
        path = File.join(directory, name)
        # write the file
        File.open(path, "wb") { |f| f.write(params[:test][:datafile].read) }
        if File.exist?(path)
        	@image_link = create_classifier(path,cascades)
        	flash[:notice] = "You have successfully upload to file."
    		respond_to do |format|
                format.html {render 'index',object: @image_link}# show.html.erb
                # format.json { render json: @adtag.as_json.merge({script: @ready_script})}
            end
    	else

            
    		flash[:notice] = "File can't upload try again."	
    	end
    end

    def create_classifier image_link , cascades
    	data = 'lib/classifier/' + cascades 
		detector = CvHaarClassifierCascade::load(data)
		image = CvMat.load(image_link)
		detector.detect_objects(image).each do |region|
		  color = CvColor::Blue
		  image.rectangle! region.top_left, region.bottom_right, :color => color
		end

		image.save_image(image_link)
        image_link.remove("public/")
    end
end
