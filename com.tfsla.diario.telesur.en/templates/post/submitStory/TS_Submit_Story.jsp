<%@ include file="../../../elements/TS_Common_Libraries.jsp" %>
<%@ include file="../../../elements/webusers/TS_RecoverySession.jsp" %>

<%	
if (!userIsLoggedIn){
	response.sendRedirect("/english/users/login_native.html?P=/english/posts/post_story.html");
	return;
}
	
boolean postOk = (request.getParameter("ok") == null ) ? false : true;
%>

<!doctype html>
<html>
<head>

	<cms:include page="../../../elements/TS_Common_Head.jsp" >
		<cms:param name="template">home</cms:param>
	</cms:include> 

	
	<script>
	$(document).ready(function(){	
		
		$('#terms').click(function(){
			$('#iframeBox2 .wpIframe').html("<iframe src='/english/pages/TS_GuidlineIamReporter.html' width='100%' height='600px'><iframe>");  
			$('#iframeBox2').fadeIn(500);
			$('body').css('overflow','hidden');
			
		});
		$('#iframeBox2, #iframeBox2 .wpClose').click(function(){
			$('#iframeBox2').fadeOut(500);		
			$('body').css('overflow','auto');	
		});		

	});
	</script>

	<link href="<cms:link>/system/modules/com.tfsla.diario.soynoticia/resources/css/jquery-ui/jquery.ui.autocomplete.custom.css</cms:link>" rel="stylesheet"/>
	<script type="text/javascript" src="<cms:link>/system/modules/com.tfsla.diario.soynoticia/resources/editors/ckeditor/ckeditor.js</cms:link>"></script>	 
</head>

<body>	

	<div id="iframeBox2">
		<div class="wpClose"><a class="close" style="cursor:pointer;">
			<p style="float: right; padding:10px; display:inline-block; color:white">Close</p>
		</a></div>
		<div class="wpIframe"></div>
	</div>		

	<cms:include page="../TS_PopUpPreview.jsp"/>

	<cms:include page="../../../elements/TS_Common_Header.jsp" >
		<cms:param name="pageTitle">You're the Reporter</cms:param>
		<cms:param name="pageSeccion">reporter</cms:param>
		<cms:param name="agenda">no</cms:param>
		<cms:param name="subMenu">si</cms:param>
		<cms:param name="latest">no</cms:param>
	</cms:include>
	
	<cms:include page="../../../elements/TS_Common_LiveBox.jsp" />
	
	<div class="wrapper"><!--wrapper--> 
	
		<!-- Banner 1 -->
		<div class="row clear marginchica">
			<div class="banners adv970">				
				<cms:include page="../../../elements/TS_Common_Banners.jsp">
					<cms:param name="template">SoyReportero</cms:param>
					<cms:param name="key">Advert-970x90</cms:param>
				</cms:include>					
			</div>
			<div class="bannerMobile">
				<cms:include page="../../../elements/TS_Common_Banners.jsp">
					<cms:param name="template">SoyReportero</cms:param>
					<cms:param name="key">Advert-468x60-a-mobile</cms:param>
				</cms:include>
			</div>
		</div>
		
		<% if (!postOk) {%>	
	                                
                	<cms:include page="TS_Submit_StoryForm.jsp" />					
			
		<% } else { %>
		
			<cms:include page="TS_Submit_StoryOK.jsp" />
		
		<% } %>	
					
	</div>		
	<!--wrapper-->

	<cms:include page="../../../elements/TS_Common_Footer.jsp" />
	

</body>
<script type="text/javascript">
<!-- script menu -->
var menu = 0
$('#header .btnMobile').click(function(){
	if(menu == 0){
		$('#nav').slideDown(750);	
		menu++
	}else{			
		$('#nav').slideUp( 750, function() {
			$('#nav').removeAttr('style');
		  });
		menu--
	}
});
</script>
</html>