$(document).ready ->
	@enableButton = () ->
		$('#createHR').prop('disabled', false)
	l = Ladda.create( document.querySelector( '#getImages' ) )
	Ladda.bind( 'input#getImages' );
	$(document).bind "ajaxSuccess", "form#searchImages", (event, xhr, settings) ->
		l.stop()
		$(".images").html ''
		images = xhr.responseJSON
		console.log images
		$.each images , (index,image) ->
			$(".images").append "<div class='col-md-3 '>
									<div class='radio'>
									  <label>
									    <input type='radio' name='optionsRadios' onclick='enableButton();' id='optionsRadios#{ index }' value='#{image.uri}'>
									    #{image.title}
									  </label>
									</div>
									<img class='thumbnail' src='#{ image.thumbnail_uri }' width=200>
								</div>"
		$(".create").show()
		$('#createHR').prop('disabled', true)
		query = $("#get_images_query").value
		$("#createcascades_object_name").value query
		console.log query 

	
	
		

