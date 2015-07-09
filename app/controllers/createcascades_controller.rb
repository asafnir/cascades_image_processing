class CreatecascadesController < ApplicationController
	def index
	end

	def search_images
		q = params[:get_images][:query]
		@images = Google::Search::Image.new(:query => q)
		respond_to do |format|
            # format.html {render 'index',object: @image_link}# show.html.erb
            format.json { render json: @images.as_json }
        end
	end

	def create
		image_url = params[:optionsRadios]
		query = params[:createcascades][:object_name]
		image_name = image_url.split("/").last
		unless image_name.index("?").nil?
			image_name = image_name.slice 0..(image_name.index("?") - 1)
		end
		begin
			download = open(image_url)
			IO.copy_stream(download, Rails.root.join("public/tmp/#{query}", image_name))
			create_cascade image_name , query
			respond_to do |format|
				flash[:notice] = "Thank you, we working now to create your Cascade Classifier"	
				format.html {render 'index'}
			end
		rescue Exception => e
			p e
		end
	end

	def create_cascade image_name , query
		# Check type of image
		type = image_name.split(".").last
		# Create samples from positve file
		res = Cascade::Classifier.createsamples image_name,type ,query
		# if true start the training
		if res
			return
			# Cascade::Classifier.training
		# else
		end
		
	end
end
