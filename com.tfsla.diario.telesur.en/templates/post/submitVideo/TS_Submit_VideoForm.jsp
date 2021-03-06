<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.opencms.relations.CmsCategoryService,org.opencms.relations.CmsCategory,java.util.List,org.opencms.jsp.CmsJspActionElement"%>
<%@ include file="../../../elements/TS_Common_Libraries.jsp" %>
<%@ include file="../../../elements/webusers/TS_RecoverySession.jsp" %>
<%@ page buffer="none" session="false" import="org.opencms.frontend.templateone.*" %>
<%@ page import="org.opencms.jsp.CmsJspActionElement"%>
<%@ page import="org.opencms.jsp.CmsJspLoginBean" %>
<%@ page import="org.opencms.file.CmsObject" %>
<%@ page import="com.tfsla.opencms.webusers.RegistrationModule" %>
<%@ page import="com.tfsla.opencms.webusers.openauthorization.*" %>
<%@ page import="com.tfsla.opencms.webusers.TfsUserHelper" %>
<%@ page import="org.opencms.file.CmsUser" %>

<%

//recupero variables del request
Boolean isPreview = ( request.getParameter("isPreview") != null ) ? Boolean.parseBoolean(request.getParameter("isPreview")) : false;
Boolean error = ( request.getParameter("error") != null ) ? Boolean.parseBoolean(request.getParameter("error")) : false;
String path = ( request.getParameter("path") != null ) ? request.getParameter("path") : null;

Boolean isEdit = (path != null) ? true : false;

String seccion = "";
String titulo = "";
String temas = "";
String autor = loginBean.getUserName();
List<String> fuentes = new ArrayList<String>();
List<String> images = new ArrayList<String>();
List<String> videos = new ArrayList<String>();
%>

	 <form action="/system/modules/com.tfsla.diario.telesur.en/templates/post/TS_ProcessPreview.jsp" id="previewForm" name="previewForm" method="post" enctype="multipart/form-data">
            	<input type="hidden" id="postId" name="postId" class="postId" value=""/>
    	</form>
	<form action="/english/posts/process.html" id="posts" name="posts" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="isEdit" id="isEdit" value="<%=isEdit%>" />
		<input type="hidden" name="path" id="path" value="<%=path%>" />
		<input type="hidden" name="seccion" id="seccion" value="imreporter" />					
		<!--variables de estado-->
		<input type="hidden" name="isPreview" id="isPreview" value="<%=isPreview%>" />
		<input type="hidden" name="isPublishAfterPreview" id="isPublishAfterPreview" value="" />
		<input type="hidden" name="isDirectPublish" id="isDirectPublish" value="" />
		<input type="hidden" name="IsAjax" id="IsAjax" value="false" />
		<input type="hidden" name="postId" id="postId" class="postId" value="" />
		<!--variables necesarias para completar formulario-->
		<input type="hidden" name="volanta" id="volanta" value="" />
		<input type="hidden" name="copete" id="copete" value="" />
		<input type="hidden" name="categories[]" id="categorias" value="" />
		<input type="hidden" name="fb" id="fb" value="false" />
		<input type="hidden" name="tw" id="tw" value="false" />
		<input type="hidden" name="contenido" id="contenido" value="" />

		<div class="row clear">
			<div class="col ">
				<div class="cont titreg desktop"> Upload your video </div>													
					
					<div class="cont clear">
						<div class="error" id="diverror" name="diverror" style="display:none">
							<div class="txtaviso">The form was not filled properly. Verify the highlighted fields.</div>
						</div>						
					</div>	
					
					<!-- inicio col-mid -->
					<div class="col-mid">
						<div class="cont" style="height:340px">	
											
							<input type="submitstory" placeholder="Title *" name="titulo" id="titulo" value='<%=titulo%>' autocomplete="off">				
							
							<div class="wpCheck">
								<div class="squaredThree">
									<input type="checkbox" id="checkFuente" onclick="javascript:fuentes.value=''"/>
									<label for="checkFuente"></label>
								</div>
								<label for="checkFuente">
									<div class="txtregister">I am the author of the content in the report *</div>
								</label>
							</div>	
							<input type="submitstory" placeholder="Sources *" id="fuentes" name="fuentes[]" value="" autocomplete="off">
							
							
							<input type="submitstory" placeholder="Tags *" name="temas" value="<%=temas%>" id="temas" autocomplete="off">	
							<div class="reg-form" id="diverrortema" name="diverrortema" style="display:none;margin:0;float:right">					
								<div class="anote error" style="margin:0;">Spaces can't be selected as a theme. </div>
							</div>
							
							<p style="font-size:1.2em;float:left;">* Required Fields</p>
						</div>
					</div>
		
					<!-- inicio col-mid -->
					<div class="col-mid">
						<div class="border_form" style="border-left:1px solid #CCC">
							<div class="cont">
								
								<div class="clear row">
									<div class="clear row">
										<p style="color:#666666;width:21%;margin-right:2%; float:left; font-size:1.4em;">Upload main image *</p>
										
										<input type="file" name="images[]" id="images[]" title="Select a picture from your computer" >										
									</div>
									
									<div class="reg-form" id="diverrorimagen" name="diverrorimagen" style="display:none">
										<div class="anote error">The image selected is in an invalid format. </div>
									</div>
									<div class="reg-form" id="diverrorimagenvacia" name="diverrorimagenvacia" style="display:none">
										<div class="anote error">Select an image to continue. </div>
									</div>		
									<div class="reg-form" id="diverrorimagensize" name="diverrorimagensize" style="display:none">
										<div class="anote error">Images can't be heavier than 2MB. </div>
									</div>														
							              	
							              	<div class="separador clear" style="margin:15px 0"></div>

								</div>
								
								<div class="clear row">
									<div class="clear row" style="margin-bottom:5px;">
										<div class="clear row">
											<p style="color:#666666;width:21%;margin-right:2%; float:left; font-size:1.4em;">URL video *</p>
										</div>									
									</div>
									<a class="subirMasVideos youtube addVid" id="youtube"  href="#">
										<div class="btn-txt">Youtube</div>
									</a>
									<!--Se hace un include del input que permitira subir un video de YOUTUBE-->
									<cms:include page="TS_Submit_VideoYoutube.jsp" />
									
									<a class="subirMasVideos clear vimeo addVid" id="vimeo"  href="#">
										<div class="btn-txt">Vimeo</div>
									</a>
									<!--Se hace un include del input que permitira subir un video de VIMEO -->
									<cms:include page="TS_Submit_VideoVimeo.jsp" />
									
									<div class="reg-form video-error" id="videoerror" name="videoerror">
										<div class="anote error"> </div>
									</div>
									<div class="reg-form" id="diverrorvideo" name="diverrorvideo" style="display:none;">
										<div class="anote error">Select an video to continue. </div>
									</div>
									
									<div id="ArchivoVideo" style="display:none;clear:both;"> 
										<label>Video selected</label> 
									</div>
						                        <div id="ArchivosVideo" style="display:none;clear:both;"> 
						                        	<label>Videos selected</label> 
						                        </div>
									<!--En #hiddenVideoContent crea el input hidden al cargar un video para luego eliminarlo 
						                            En #videosContent agrega el div con el nombre del video y el boton eliminar para el usuario-->
									<div id="hiddenVideoContent"></div>								
									<div id="videosContent" style="clear:both;margin-bottom: 30px;"></div>		
							              	
							              	<div class="separador clear" style="margin:15px 0"></div>
								</div>
																		 								

								<div class="checkline">
									<div class="squaredThree">
										<input type="checkbox" id="acceptTerms" />
										<label for="acceptTerms"></label>
									</div>
									<div class="txtregister">
										<label for="acceptTerms">
											<a id="terms" style="margin-left:0px;cursor:pointer;"> I accept the terms of use *</a> 
										</label>										
									</div>
								</div>
								<div class="reg-form" id="diverrorterms" name="diverrorterms" style="display:none">
									<div class="anote error">I accept the terms and conditions.</div>
								</div>								
		
								<div class="clear"></div>																
								
								<a style="color:#C11717;font-size: 1.4em;display:block;margin:30px 0;text-align:center;cursor:pointer" onclick="ValidateForm('isPreview');" title="Report's preview" alt="Report's preview">Report's preview</a>
								
								<input type="submit" id="subscribe" value="Send" onclick="ValidateForm('isDirectPublish'); return false;" title="Send">								
								<input id="cancelar" type="button" onclick="window.location.href='<cms:link>/seccion/imreporter/</cms:link>';" value="Cancel" title="Cancel">
							</div>
						</div>
					</div>
					<!-- fin col-midx -->
			</div>
		</div>	
		
		<div class="separador"></div>
	</form>
	<form action="/english/posts/publishAfterPreview.html" id="PublishAfterPreview" name="PublishAfterPreview" method="post">
		<input type="hidden" name="path" value="<%=path%>" />
		<input type="hidden" name="isEdit" value="false" />
		<input type="hidden" name="isPreview" value="false" />
		<input type="hidden" name="isPublishAfterPreview" value="true" />
		<input type="hidden" name="isDirectPublish" value="false" />
	</form> 
<script type="text/javascript">
	var postId = "";
	function ValidateForm(mode){
		var e_titulo = false;		
		var e_temas = false;
		var e_temas_espacios = false;
		var e_fuente = false;
		var e_accept_terms = true;
		var e_video_vacio = false;
		var e_imagen_vacia = false;
		var e_imagen_size = false;
		var e_imagen_format = false;
		var isEdit = <%=isEdit %>;
		$(".postId").val(postId);
		 
		//validos campos obligatorios del form
		if ( document.getElementById('titulo').value.replace(/\s/g, '').length == 0 ) e_titulo = true;				
		if ( document.getElementById('temas').value.replace(/\s/g, '').length == 0 ) e_temas = true;
		var t = document.getElementById('temas').value;
		var arrayTemas = t.split(",");
		for (var k = 0; k < arrayTemas.length; k++){
			if (arrayTemas[k] == " ")
				e_temas_espacios = true;
		}	
		if ( document.getElementById('fuentes').value.replace(/\s/g, '').length == 0 ) e_fuente = true;
		if ($('#fuentes').length == 0) { e_fuente = true; }
		if ($('#checkFuente').is(':checked') && e_fuente){ e_fuente = false; }	
		if ($('#acceptTerms').is(':checked') ){ e_accept_terms = false; }
		
		//para previsualizar no es obligatorio que valide el campo
		if ( mode == 'isPreview' ) {
			e_accept_terms = false;
		}
		
		//seteo carteles de error								
		if ( e_titulo ) 
			document.getElementById('titulo').className = "mal";
		else	
			document.getElementById('titulo').className = "";
		
		if ( e_temas || e_temas_espacios ) 
			document.getElementById('temas').className = "mal";
		else	
			document.getElementById('temas').className = "";

		if ( e_fuente ) 
			document.getElementById('fuentes').className = "mal";
		else	
			document.getElementById('fuentes').className = "";					
		
		var videosFiles = $('.wpArchivoImg').length;	
		
		if(videosFiles == 0){
			e_video_vacio = true;				
		}
		
		var files = $('input[name="images[]"]')[0].files;
		var filesCount = 0;
		
		if(files != null)
			filesCount = files.length;
		
		if(filesCount == 0){
			e_imagen_vacia = true;				
		}

		if(!e_imagen_vacia){
		
			for (var i = 0; i < filesCount; i++)
			{
				var oFile = files[i];
				var filename = oFile.fileName;
				
				if ('name' in oFile)
					filename = oFile.name;
				
				if(!oFile.name.toLowerCase().match("\\S+\\.(jpg|png|gif|jpeg)$")){						
					e_imagen_format = true;
					break;
				}
				
				//2MB = 2097152
				if(oFile.size > 2097152){
					e_imagen_size = true;
					break;					
				}
				
			}
		}		
		
		if( e_titulo || e_temas || e_temas_espacios || e_video_vacio || e_fuente || e_accept_terms || e_imagen_vacia || e_imagen_size || e_imagen_format ){
			if ( e_titulo || e_temas || e_temas_espacios || e_video_vacio || e_fuente || e_accept_terms || e_imagen_vacia || e_imagen_size || e_imagen_format ) {
				document.getElementById('diverror').style.display = "block";
			}else{
				document.getElementById('diverror').style.display = "none";
			}
			
			if (e_temas_espacios ) 
				document.getElementById('diverrortema').style.display = "block";
			else	
				document.getElementById('diverrortema').style.display = "none";
				
			if ( e_video_vacio ) {					
				document.getElementById('diverrorvideo').style.display = "block";
			}else{
				document.getElementById('diverrorvideo').style.display = "none";
			}
			
			if ( e_accept_terms ) {				
				document.getElementById('diverrorterms').style.display = "block";
			}else{
				document.getElementById('diverrorterms').style.display = "none";
			}	
			
			if ( e_imagen_vacia ) {					
				document.getElementById('diverrorimagenvacia').style.display = "block";
			}else{
				document.getElementById('diverrorimagenvacia').style.display = "none";
			}
				
			if ( e_imagen_format ) {					
				document.getElementById('diverrorimagen').style.display = "block";
			}else{
				document.getElementById('diverrorimagen').style.display = "none";
			}
			
			if ( e_imagen_size ) {					
				document.getElementById('diverrorimagensize').style.display = "block";
			}else{
				document.getElementById('diverrorimagensize').style.display = "none";
			}		
			$('body, html').animate({scrollTop: 0}, 300);				
		} else {
			document.getElementById('diverror').style.display = "none";
			document.getElementById('diverrortema').style.display = "none";
			document.getElementById('diverrorterms').style.display = "none";		
			document.getElementById('diverrorvideo').style.display = "none";
			document.getElementById('diverrorimagenvacia').style.display = "none";	
			document.getElementById('diverrorimagen').style.display = "none";
			document.getElementById('diverrorimagensize').style.display = "none";
			
			//reseteo los campos de los videos
			var inp1 = $('#VideoVimeo');
			inp1.val('');
			var inp2 = $('#VideoYoutube');
			inp2.val('');
			$('.video-error .error').text('').hide();
			
			if ( mode == 'isPreview' ) {
		                ShowPreview();
			}else if ( mode == 'isPublishAfterPreview' ) {
				document.getElementById('PublishAfterPreview').submit();
				$('#buttonPublicar').prop('disabled',true);
			}else if ( mode == 'isDirectPublish' ) {
		                $('#buttonPublicar').prop('disabled',true);
		                document.getElementById('isDirectPublish').value = "true";
		                document.getElementById('posts').submit();
			}
		}
	}
	
	//check de fuente - bloqueo y desbloqueo
	$('#checkFuente').change(function(){
		if ($("#fuentes").is(":disabled")) {
				$('#fuentes').prop('disabled', false);
			}
			else {
				$('#fuentes').prop('disabled', 'disabled');
			}
		 $('#fuentes').attr('value',"");
	});
	
	function ShowPreview(){
		$('#iframeBox .wpIframe').css('display','none');
		$('#iframeBox').fadeIn(500);		
		$('#popupPreview').fadeIn(500);
		$('body').css('overflow','hidden');	
		var data = new FormData();
		
		data.append('titulo', document.getElementById('titulo').value);
		data.append('volanta', document.getElementById('volanta').value);
		data.append('copete', document.getElementById('copete').value);
		data.append('seccion', document.getElementById('seccion').value);
		data.append('contenido', document.getElementById('contenido').value);
		data.append('temas', document.getElementById('temas').value);
		data.append('fb', document.getElementById('fb').value);
		data.append('tw', document.getElementById('tw').value);
		
		data.append('categories[]', document.getElementById('categorias').value);
		data.append('path', document.getElementById('path').value);
		data.append('isEdit',document.getElementById('isEdit').value);
		data.append('isPreview', 'true');
		data.append('isPublishAfterPreview', 'false');
		data.append('isDirectPublish', 'false');		
		data.append('IsAjax', 'true');
		data.append('postId', postId);
		
		jQuery.each( $('[name="categoria[]"]'), function(j) {
			categoria = $(this).val();
			data.append('categoria['+j+']', categoria);
		});
		
		jQuery.each( $('input[name="fuentes[]"]'), function(j) {
			fuente = $(this).val();
			data.append('fuente['+j+']',fuente);
		});
		
		jQuery.each( $('input[name="videos[]"]'), function(k) {
			video = $(this).val();
			data.append('videos['+k+']',video);
		});
			
		jQuery.each( $('input[name="images[]"]')[0].files, function(i, file) {
			data.append('images['+i+']', file);
		});
		
		$.ajax({
			url: '/system/modules/com.tfsla.diario.telesur.en/templates/post/TS_Process.jsp',
			data: data,
			cache: false,
			contentType: false,  
			processData: false,
			type: 'POST',
			success: function(data){
			
			var result = $(data).find('result').text();
			var valueResult = $(data).find('message').text();
                        
			if( valueResult !=""){
		                postId = valueResult;
		                $(".postId").val(postId);
		                
					$.post('/system/modules/com.tfsla.diario.telesur.en/templates/post/TS_Preview.jsp', { id: valueResult, preview: true } ,
					function(txt) {  
						var text = txt;	
						$('#iframeBox .wpIframe').css('display','block');						
						$("#iframeBox .wpIframe").html("<iframe srcdoc='"+text+"' src='/posts/preview.html' width='600px' height='600px'><iframe>");							
					});
					$('#popupPreview').fadeOut(1000);										
					$('#iframeBox .wpClose').click(function(){
						$('#iframeBox').fadeOut(500);		
						$('body').css('overflow','auto');
					});		
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
			  	alert(errorThrown);
			}
		});
		
		$('body, html').animate({scrollTop: 0}, 300);			
	}
</script>
<script type="text/javascript">
	//Cargar multiples videos
	$(function(){
		
		$('#addVideoVimeo').on('click', function(e){
			e.preventDefault();
			var input = $('#VideoVimeo'),
			url = input.val(),
				clientName = $(".headVimeo").find('.clientName').text();
			if(url == ''){
				showError('Complete the URL field');
				return;
			}
	
			checkVideoUrl(clientName, url);
		});
		
		$('#addVideoYoutube').on('click', function(e){
			e.preventDefault();
			var input = $('#VideoYoutube'),
			url = input.val(),
				clientName = $(".headYoutube").find('.clientName').text();
			if(url == ''){
				showError('Complete the URL field');
				return;
			}
	
			checkVideoUrl(clientName, url);
		});
		
		function checkVideoUrl(clientName, url){
			var idArr;
			var id = null;
			if(clientName == 'YOUTUBE'){
				idArr = url.split('watch?v=');
				if(idArr[1]!=undefined){
					id = idArr[1].split('&')[0];	
				}
				
				idArr = url.split('.be/');
				if(idArr[1]!=undefined){
					id = idArr[1].split('&')[0];
				}
				
				if(id == null){
					showError('Type a valid URL');
					return;
				}	
	
			}
			
			if(clientName == 'VIMEO'){
				idArr = url.split('vimeo.com/');
				if(idArr[1]!=undefined){
					id = idArr[1];
				}
				if(id == null){
					showError('Type a valid URL');
					return;
				}	
			}
			
			createVideo(clientName, id);
			
		}
		
		var idVideosCargados = [];
		function createVideo (clientName, id){
			var i=0,
				k = idVideosCargados.length;
			if(k==20){
				showError("You've reach the limit of uploaded videos");
				return;
			}
			for(;i<k;i++){
				if(idVideosCargados[i] == id){
					showError('The video was already uploaded');
					return;
				}
			}			
			clientName = clientName.toLowerCase();
			var iframeSrc;
			if(clientName == 'youtube')
				iframeSrc = 'http://www.youtube.com/embed/'+id ;
			if(clientName == 'vimeo')
				iframeSrc = 'http://player.vimeo.com/video/'+id ;
			var video = '<div id="'+id+'" class="wpArchivoImg">'+iframeSrc+'   <a class="video-delete" style="cursor:pointer;">REMOVE</a></div>';
			var hidden = '<input type="hidden" name="videos[]" value="'+iframeSrc+'" />';
			$('#hiddenVideoContent').append(hidden);
	
			if (k == 0 ){
				document.getElementById("ArchivosVideo").style.display = "none"; 
				document.getElementById("ArchivoVideo").style.display = "block"; 		
			}
			if (k > 0 ){ 
				document.getElementById("ArchivoVideo").style.display = "none"; 
				document.getElementById("ArchivosVideo").style.display = "block"; 			
			}
			
			$('#videosContent').append(video);	
			idVideosCargados.push(id);
			hideError();	
		}		
		
		function showError(txt){
			$('.video-error .error').text(txt).show();
		}
		
		function hideError(){
			var inp1 = $('#VideoVimeo');
			inp1.val('');
			var inp2 = $('#VideoYoutube');
			inp2.val('');
			$('.video-error .error').text('').hide();
		}					
		
		$('#videosContent').on('click', '.video-delete', function(e){
			e.preventDefault();
			var content = $(this).closest('.wpArchivoImg');
				videoPos = content.index(),
				input = $('#hiddenVideoContent').find('input');
			input.eq(videoPos).remove();
			idVideosCargados.splice(videoPos-1, 1); 
			content.fadeOut(function(){
				$(this).remove();
				
			});		
		});		
		
	});		
</script>