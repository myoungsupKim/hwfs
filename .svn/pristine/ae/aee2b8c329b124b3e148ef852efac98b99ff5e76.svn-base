/*
 * Copyright 2001-2007 by HANWHA S&C Corp.,
 * All rights reserved.
 * 
 * This software is the confidential and proprietary information
 * of HANWHA S&C Corp. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with HANWHA S&C Corp.
 */
/** 
 * @fileoverview LightWeight Progress 팝업창
 *
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 2.0 
 */

/**
 * ProgressPane 객체 생성자
 * @class Progress 팝업창을 띄우고 팝업창이 떠있는 동안 화면에 있는 버튼들을 클릭하지 못하게 함
 * @constructor
 * @return A new ProgressPane
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 2.0 
 */
hanwha.commons.ProgressPane = function ProgressPane(name) {
	this.name = name;
	this.timeout = 30;
	this.isRunning = false;
	this.displayActiveX = true;
	this.PROGRESS_WINDOW_MESSAGE = 
	new Array("잠시만 기다려 주십시오...", "처리 중입니다...", "처리가 지연되고 있습니다.<br>잠시만 더 기다려 주십시오....");  
};

hanwha.commons.ProgressPane.prototype = {

	/**
	 * 화면 크기 계산
	 * @private
	 */
	getPageSize : function() {
		var xScroll, yScroll;
		var bodyFrame = document.body;
		try {
			if (document.body.length > 1)
			{
				bodyFrame = document.body[0];
			}
		}
		catch (e){}
		if (window.innerHeight && window.scrollMaxY) {	
			xScroll = bodyFrame.scrollWidth;
			yScroll = window.innerHeight + window.scrollMaxY;
		} else if (bodyFrame.scrollHeight > bodyFrame.offsetHeight){
			xScroll = bodyFrame.scrollWidth;
			yScroll = bodyFrame.scrollHeight;
		} else {
			xScroll = bodyFrame.offsetWidth;
			yScroll = bodyFrame.offsetHeight;
		}
		
		var windowWidth, windowHeight;
		if (self.innerHeight) {	
			windowWidth = self.innerWidth;
			windowHeight = self.innerHeight;
		} else if (document.documentElement && document.documentElement.clientHeight) { 
			windowWidth = document.documentElement.clientWidth;
			windowHeight = document.documentElement.clientHeight;
		} else if (bodyFrame) { 
			windowWidth = bodyFrame.clientWidth;
			windowHeight = bodyFrame.clientHeight;
		}	
		if(yScroll < windowHeight){
			pageHeight = windowHeight;
		} else { 
			pageHeight = yScroll;
		}
		if(xScroll < windowWidth){	
			pageWidth = windowWidth;
		} else {
			pageWidth = xScroll;
		}
		arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight) 
		return arrayPageSize;
	},

	/**
	 * @private
	 */
	pause : function(numberMillis) {
		var now = new Date();
		var exitTime = now.getTime() + numberMillis;
		while (true) {
			now = new Date();
			if (now.getTime() > exitTime)
				return;
		}
	},

	/**
	 * @private
	 */	
	getKey : function(e){
		if (e == null) { 
			keycode = event.keyCode;
		} else {
			keycode = e.which;
		}
		key = String.fromCharCode(keycode).toLowerCase();
		//if(key == 'x'){ hideLightbox(); }
	},

	/**
	 * @private
	 */	
	listenKey : function() {	
		document.onkeypress = this.getKey; 
	},
	
	/**
	 * @private
	 */	
	showOverlayWindow : function(objLink) {
		var objOverlay = document.getElementById('overlay');
		var arrayPageSize = this.getPageSize();
		objOverlay.style.height = (arrayPageSize[1] + 'px');
		objOverlay.style.display = 'block';
		arrayPageSize = this.getPageSize();
		objOverlay.style.height = (arrayPageSize[1] + 'px');
	}, 

	/**
	 * @private
	 */	
	hideOverlayWindow : function ESB_HideOverlayWindow()
	{
		objOverlay = document.getElementById('overlay');
		objOverlay.style.display = 'none';
		selects = document.getElementsByTagName("select");
		for (i = 0; i != selects.length; i++) {
			selects[i].style.visibility = "visible";
		}
		document.onkeypress = '';
	},

	/**
	 * Progress 팝업이 보여지는 동안 화면에서 ActiveX를 감출지 여부 (기본값 : true)
	 * @param {boolean} daFlag 감춤 여부 (true or false)
	 */
	setDisplayActiveX : function(daFlag){
		this.displayActiveX = daFlag;
	},

	/**
	 * 초기화
	 */
	init : function()	{
		var objBody = document.getElementsByTagName("body").item(0);
		var overlayHTML;
		overlayHTML = '<div id="overlay" style="display:none;position:absolute;top:0;left:0;zIndex:90;width:100%;filter:alpha(opacity=0);background-color:#3C3D3F;"></div>';
		var progressHTML;
		progressHTML = '<div align="center" id="_splashcontainer" style="VISIBILITY:  hidden;position:absolute;z-index:3;left:400px;top:300px;">';
		progressHTML += '	<table align="center" width="275" cellspacing="0" cellpadding="0">';
		progressHTML += '		<tr>';
		progressHTML += '			<td style="background-color :#575757;" align="center">';
		progressHTML += '				<table width="275" style="background-color:#ffffff; padding:5px;margin:5px;border:1px solid #cecece;border-bottom:2px solid #9e9e9e;border-right:1px solid #9e9e9e;">';
		progressHTML += '					<tr>';
		progressHTML += '						<td>';
		progressHTML += '							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color :#FFFFFF;padding:10px;margin:10px;border:1px">';
		progressHTML += '								<tr style="font-size: 9pt;">';
		progressHTML += '									<td width="*" align="left">';
		progressHTML += '									<span id="_progressMessageSpan"></span>';
		progressHTML += '									</td>';
		progressHTML += '									<td width="60">';
		progressHTML += '									<img align="absmiddle" src="'+agentRoot+'/lib/images/loading.gif">';
		progressHTML += '									</td>';
		progressHTML += '								</tr>';
		progressHTML += '							</table>';
		progressHTML += '						</td>';
		progressHTML += '					</tr>';
		progressHTML += '				</table>';
		progressHTML += '			</td>';
		progressHTML += '		</tr>';
		progressHTML += '	</table>';
		progressHTML += '</div>';
		var customHTML;
		customHTML = '<div align="center" id="_customsplashcontainer" style="VISIBILITY:  hidden;position:absolute;z-index:3;left:400px;top:300px;">';
		customHTML += '	<table align="center" width="275" cellspacing="0" cellpadding="0">';
		customHTML += '		<tr>';
		customHTML += '			<td style="background-color :#575757;" align="center">';
		customHTML += '				<table width="275" style="background-color:#ffffff; padding:5px;margin:5px;border:1px solid #cecece;border-bottom:2px solid #9e9e9e;border-right:1px solid #9e9e9e;">';
		customHTML += '					<tr>';
		customHTML += '						<td id="_customHTML">';
		customHTML += '						</td>';
		customHTML += '					</tr>';
		customHTML += '				</table>';
		customHTML += '			</td>';
		customHTML += '		</tr>';
		customHTML += '	</table>';
		customHTML += '</div>';	

		objBody.insertAdjacentHTML("beforeEnd", overlayHTML);
		objBody.insertAdjacentHTML("beforeEnd", progressHTML);
		objBody.insertAdjacentHTML("beforeEnd", customHTML);
	},

	/**
	 * @private
	 */	
	addLoadEvent : function(func)
	{	
		var oldonload = window.onload;
		if (typeof window.onload != 'function'){
			window.onload = func;
		} else {
			window.onload = function(){
			oldonload();
			func();
			}
		}

	},

	/**
	 * Progress 팝업창 띄움
	 */	
	showProgressWindow : function(msgIdx, customMsg, customHight){
		var bodyFrame = document.body;
		try {
			if (document.body.length > 1)
			{
				bodyFrame = document.body[0];
			}
		} catch (e){}
		if (!this.displayActiveX)
		{
			var objTags = document.all.tags("OBJECT");
			try {
				for (var i=0; i < objTags.length; i++) {
					try {
						if( objTags[i].MimeValue ){
							continue;
						}
					} catch (e) {
						//alert("e : " + e.description);
					}
					try {
						objTags[i].style.display = 'none';
					} catch (e) {
						//alert("e : " + e.description);
					}
				}
			} catch( error ) {}
		}

		window.status = "";
		if (document.all){
			this.showOverlayWindow();
			sc_ie=document.all._splashcontainer;
			sc_ie.style.left=bodyFrame.scrollLeft+bodyFrame.clientWidth/2-sc_ie.offsetWidth/2;
			if (customHight != null)
			{
				sc_ie.style.top=customHight;
			} else {
				sc_ie.style.top=bodyFrame.scrollTop+bodyFrame.clientHeight/2-sc_ie.offsetHeight/2;
			}
			sc_ie.style.visibility = "visible";
			sc_ie.style.zIndex = '100';	
			this.isRunning = true;
			if (msgIdx == null)
			{
				msgIdx = 0;
			}
			if (msgIdx > -1)
			{
				this.showProgressMessage(0);
			} else {
				this.setProgressMessage(customMsg);
			}
		}
	},

	/**
	 * Progress 팝업창 닫음
	 */	
	hideProgressWindow : function() {
		var bodyFrame = document.body;
		try {
			if (document.body.length > 1)
			{
				bodyFrame = document.body[0];
			}
		} catch (e){}

		if (!this.displayActiveX)
		{
			var objTags = document.all.tags("OBJECT");
			try {
				for (var i=0; i < objTags.length; i++) {
					try {
						objTags[i].style.display = 'block';
					} catch (e) {
						//alert("e : " + e.description);
					}
				}
			} catch( error ) {}
		}
		this.isRunning = false;
		this.hideOverlayWindow();
		sc_ie=document.all._splashcontainer;
		sc_ie.style.visibility="hidden";
		window.status = "";
	},

	/**
	 * @private
	 */	
	showProgressMessage : function( index ) { 
		if (!this.isRunning)
		{
			return;
		}
		focus();
		interval = 1000;
		index++;
		if (index > this.timeout ) { 
			alert("시간이 초과 되었습니다.");
			this.hideProgressWindow();
			return; 
		} else if (index > this.timeout/2) { 
			this.setProgressMessage(this.PROGRESS_WINDOW_MESSAGE[2]); 
		} else {
			this.setProgressMessage(this.PROGRESS_WINDOW_MESSAGE[(index % 2)]);
		}
		progressWindowTimer = setTimeout(this.name+".showProgressMessage(" + index + ")", interval); 
	},

	/**
	 * @private
	 */	
	setProgressMessage : function(msgSrc) {
		_progressMessageSpan.innerHTML = msgSrc;
	},

	/**
	 * @private
	 */	
	showCustomWindow : function(_html, interval) {
		var bodyFrame = document.body;
		try {
			if (document.body.length > 1)
			{
				bodyFrame = document.body[0];
			}
		}
		catch (e){}
		if (!this.displayActiveX)
		{
			var objTags = document.all.tags("OBJECT");
			try {
				for (var i=0; i < objTags.length; i++) {
					try {
						objTags[i].style.display = 'none';
					} catch (e) {
						//alert("e : " + e.description);
					}
				}
			} catch( error ) {}
		}
		window.status = "";
		if (document.all){
			this.showOverlayWindow();
			_customHTML.innerHTML = _html;
			sc_ie=document.all._customsplashcontainer;
			sc_ie.style.left=bodyFrame.scrollLeft+bodyFrame.clientWidth/2-sc_ie.offsetWidth/2;
			sc_ie.style.top=bodyFrame.scrollTop+bodyFrame.clientHeight/2-sc_ie.offsetHeight/2;
			sc_ie.style.visibility = "visible";
			sc_ie.style.zIndex = '100';	
			this.isRunning = true;
			if (interval == null)
			{
				interval = 0;
			}
			if (interval > -1)
			{
				setTimeout(this.name+".hideCustomWindow()", interval); 
			}
		}
	},

	/**
	 * @private
	 */	
	hideCustomWindow : function(){
		this.isRunning = false;
		this.hideOverlayWindow();
		sc_ie=document.all._customsplashcontainer;
		sc_ie.style.visibility="hidden";
		window.status = "";
	}

};