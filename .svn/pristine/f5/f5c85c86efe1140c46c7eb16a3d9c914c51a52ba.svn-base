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
 * ModalDialog 객체 생성자
 * @class IE의 showModalDialog 대신 사용할 수 있으며 window.open()을 사용하여 팝업을 띄움 
 * @constructor
 * @return A new ModalDialog
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 1.0 
 */
hanwha.commons.ModalDialog = function ModalDialog(n) {
	this.name = n;
	this.modalDialogWindow;
	this.modalDialogInterval;
	this.callbackMethod = null;
	this.isInit = false;

	this.init = function () {
		if (!this.isInit)
		{
			if (!mdoverlay) {
				var objBody = document.getElementsByTagName("body").item(0);
				var overlayHTML;
				overlayHTML = '<div id="mdoverlay" onclick="'+this.name+'.modalDialogMaintainFocus(true);" style="display:none;position:absolute;top:0;left:0;zIndex:90;width:100%;filter:alpha(opacity=0);background-color:#3C3D3F;"></div>';
				objBody.insertAdjacentHTML("beforeEnd", overlayHTML);
				this.isInit = true;
			}
		}
	};

	this.getPageSize = function(){
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
	};

	this.showOverlayWindow = function(objLink){
		var objOverlay = document.getElementById('mdoverlay');
		var arrayPageSize = this.getPageSize();
		objOverlay.style.height = (arrayPageSize[1] + 'px');
		objOverlay.style.display = 'block';
		arrayPageSize = this.getPageSize();
		objOverlay.style.height = (arrayPageSize[1] + 'px');
	};

	this.hideOverlayWindow = function() {
		objOverlay = document.getElementById('mdoverlay');
		objOverlay.style.display = 'none';
		selects = document.getElementsByTagName("select");
		for (i = 0; i != selects.length; i++) {
			selects[i].style.visibility = "visible";
		}
		document.onkeypress = '';
	};

	this.modalDialogMaintainFocus = function (setFocus) {
		try {
			if (this.modalDialogWindow.closed) {
				this.hideOverlayWindow();
				window.clearInterval(this.modalDialogInterval);
				//alert("closed");
				if (this.callbackMethod != null)
				{
					this.callbackMethod();
				}
				return;
			}
			if ( setFocus ) {
				this.modalDialogWindow.focus(); 
			}
		} catch (everything) {}
	};

	this.show = function (targetSiteURL,w,h) {
		wleft = (screen.availWidth-w)/2;
		wtop = (screen.availHeight-h)/2;
		
		var args='width='+w+',height='+h+',left='+wleft+',top='+wtop+',toolbar=0,';
		args+='location=0,status=0,menubar=0,scrollbars=1,resizable=1';  
		this.modalDialogWindow=window.open(targetSiteURL,"ModalDialog",args); 
		this.modalDialogWindow.focus(); 
		this.modalDialogInterval = window.setInterval(this.name+".modalDialogMaintainFocus()",5);
		this.init();
		this.showOverlayWindow();
	};

}