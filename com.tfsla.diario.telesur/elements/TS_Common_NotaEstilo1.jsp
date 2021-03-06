<%@ include file="TS_Common_Libraries.jsp" %>

<% String path = (request.getParameter("path") != null ) ? request.getParameter("path") : "" ; %>

<nt:news path="<%=path%>">   
	<div class="bordercountry" itemscope itemtype="http://schema.org/Article">
		<div class="blue" itemprop="name headline">
			<a href="<nt:link />" class="her" alt='<nt:title value="section" />' title='<nt:title value="section" />'><h1><nt:title value="section" /></h1></a>
			<nt:edit-buttons hasNew="true" hasDelete="true"/>
		</div>
		<nt:conditional-include oncondition="${news.homePreview == 'imagen'}">
			<nt:preview-image>
				<div class="img-destnew" itemscope itemtype="http://schema.org/ImageObject">
					<a href="<nt:link />" class="her">
						<c:set var="imageDescription" scope="page"><nt:image-description/></c:set>
						<nt:conditional-include oncondition="${imageDescription != ''}">
							<meta itemprop="description" content='<nt:image-description/>'>	
							<img itemprop="contentURL" src="<nt:image-path width='541' height='341' scaletype='2'/>" alt='<nt:image-description/>' title='<nt:image-description/>'>
						</nt:conditional-include>
						<nt:conditional-include oncondition="${imageDescription == ''}">
							<meta itemprop="description" content='${news.titles[news.titleSectionNum]}'>
							<img itemprop="contentURL" src="<nt:image-path width='541' height='341' scaletype='2'/>" alt='${news.titles[news.titleSectionNum]}' title='${news.titles[news.titleSectionNum]}'>
						</nt:conditional-include>
					</a>
				</div>
			</nt:preview-image> 
		</nt:conditional-include>
		<nt:conditional-include oncondition="${news.homePreview == 'videoYouTube'}">
			<div class="img-destnew npc" itemscope itemtype="http://schema.org/VideoObject">
				<c:set var="y" value="0" />
				<nt:video-youtube>	
					<c:set var="y" value="${y+1}" />
					<c:set var="videoHomeY"><nt:generic-news-value element='videoFlash[${y}]/mostrarEnHome'/></c:set>	
					<nt:conditional-include oncondition="${videoHomeY == 'true'}">
						<meta itemprop="name" content='<nt:video-title/>' />
						<meta itemprop="publisher" content="<nt:video-publisher/>" />
						<meta itemprop="thumbnailUrl" content="//i1.ytimg.com/vi/<nt:video-youtubeid/>/hqdefault.jpg" />
						<meta itemprop="contentURL" content="http://www.youtube.com/v/<nt:video-youtubeid/>" />				
						<iframe width="100%" src="//www.youtube.com/embed/<nt:video-youtubeid/>" frameborder="0" allowfullscreen></iframe>	
					</nt:conditional-include>			
				</nt:video-youtube>
			</div>
		</nt:conditional-include>
		<nt:conditional-include oncondition="${news.homePreview == 'iframe'}">
			<div class="img-destnew npc">			
				<nt:iframe/>				
			</div>
		</nt:conditional-include>
		<nt:conditional-include oncondition="${news.homePreview == 'videoEmbedded'}">
			<div class="img-destnew npc" itemscope itemtype="http://schema.org/VideoObject">
				<nt:video-embedded>
					<nt:conditional-include onposition="1">
						<meta itemprop="name" content='<nt:video-title/>' />	
						<nt:video-code/>
					</nt:conditional-include>
				</nt:video-embedded>
			</div>
		</nt:conditional-include>
		
		<nt:conditional-include oncondition="${news.homePreview == 'videoFlash'}">
			<div class="img-destnew npc" itemscope itemtype="http://schema.org/VideoObject">
				<c:set var="videopath" value=""/>
				<nt:video-flash>	
					<nt:conditional-include onposition="1">
						<c:set var="videopath">${videopath}<nt:video-path/>,<nt:video-thumbnail/>,<nt:video-title/></c:set>
					</nt:conditional-include>
					<nt:conditional-exclude onposition="1">
						<c:set var="videopath">${videopath};<nt:video-path/>,<nt:video-thumbnail/>,<nt:video-title/></c:set>
					</nt:conditional-exclude>
					<nt:conditional-include onposition="last">
						<meta itemprop="name" content='<nt:video-title/>' />
						<meta itemprop="publisher" content="<nt:video-publisher/>" />
  						<meta itemprop="thumbnailUrl" content="<nt:video-thumbnail/>" />
						<meta itemprop="contentURL" content="<nt:video-path/>" />
						<meta itemprop="keywords" content="<nt:video-tags/>" />	
						<meta itemprop="duration" content="<nt:video-duration/>" />
						<meta itemprop="bitrate" content="<nt:video-bitrate/>" />		
						<cms:include page="TS_Common_VideoFlash.jsp">
							<cms:param name="video">${videopath}</cms:param>
							<cms:param name="width" value="100%"/>
							<cms:param name="height" value="100%"/>
						</cms:include>
					</nt:conditional-include>							
				</nt:video-flash>
			</div>
		</nt:conditional-include>
		<nt:conditional-include oncondition="${news.subtitle != '' && news.hideCopete == 'false'}">
			<div itemprop='description alternativeHeadline'>		
				<p><nt:sub-title/><a class="blue fullbtn" href='<nt:link />' alt="Leer Más" title="Leer Más" > Leer Más</a></p>
			</div>
		</nt:conditional-include>
	</div>
	<div class="separador margensep"></div>
</nt:news>