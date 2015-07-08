module Cascade
	class Classifier
		
		def createsamples image_name,type
			if type=="jpg"
				cmd = "opencv_createsamples -img /home/user/#{} -bg /home/user/bg.txt -info /home/user/annotations.lst -pngoutput -maxxangle 0.1 -maxyangle 0.1 -maxzangle 0.1 -vec file_name -w 80 -h 80"
				res = system(cmd)
				return res
			elsif type="png"
				cmd = "opencv_createsamples -img /home/user/logo.png -bg /home/user/bg.txt -info annotations.lst -maxxangle 0.1 -maxyangle 0.1 -maxzangle 0.1 -vec file_name -w 80 -h 80"
				res = res
			else
				return false
			end
		end

		def training
		  cmd = "opencv_traincascade -data #{Rails.root.join("classifier")} -vec samples.vec -bg negatives.txt
		  numStages 20 -minHitRate 0.999 -maxFalseAlarmRate 0.5 -numPos 1000
		  numNeg 600 -w 80 -h 40 -mode ALL -precalcValBufSize 1024
		  precalcIdxBufSize 1024"
		  # TrainingWorker.perform_async cmd
		  system(cmd)
		end

	end
end