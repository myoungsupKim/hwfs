(function($) {
	var winxp = true;
	var winxpSP2 = true;
	var winxpSP2InfoPath = false;
	try{
		var agt = navigator.userAgent.toLowerCase();
		if (jQuery.browser.msie) {
			winxp = ((agt.indexOf("windows nt 5.1")!=-1));
			winxpSP2 = ( winxp && (agt.indexOf("sv1")!=-1));
			winxpSP2InfoPath = ( winxpSP2 && (agt.indexOf("infopath.1")!=-1) && (agt.indexOf(".net clr")==-1) );
		}
	}catch(e){}

	jQuery.agentInfo  = {
		winxp : winxp,
		winxpSP2 :winxpSP2,
		winxpSP2InfoPath : winxpSP2InfoPath
	};
})(jQuery);


(function($) {
	jQuery.modal = function(options) {
		var defaults = {
			url: "",
			title: "",
			param: "",
			context: agentRoot,
			scroll: "auto",
			pos: "center",
			left: "0",
			top: "0",
			modal: "Y",
			win: (window.dialogArguments) ? window.dialogArguments.win : window,	// 상위 window 전달(window 객체는 항상 최상위를 유지)
			width: 350,
			height: 100,
			resizable: "no",
			onClose: function cb(val) { }
		};
		var options = $.extend(defaults, options);
		return jQuery.modal.util.showDialog(options);
	};
	jQuery.modeless = function(options) {
		var defaults = { modal: "N" };
		var options = $.extend(defaults, options);
		return jQuery.modal(options);
	};	
	jQuery.modal.util = {
		getAppendHeightByAgent: function() {
			var iHeight = 0;			
			if (jQuery.agentInfo.winxp) {
				iHeight += 7;
			}
			if (jQuery.agentInfo.winxpSP2InfoPath) {
				iHeight += 12;
			} else if (jQuery.agentInfo.winxpSP2) {
				iHeight += 18;
			}
			return iHeight;
		},
		showDialog: function(options) {
			var rtnVal;
			
			//본문 스크롤을 위해 변경 2015-03-24 by kksoo
			//options.height += this.getAppendHeightByAgent();
			options.height = parseInt(options.height) + this.getAppendHeightByAgent();
			
			var features = "dialogHeight:"+options.height+"px;dialogWidth:"+options.width+"px;";
			if (options.pos == "relative") {
				try {
					var x = event.x; 
					var y = event.y; 
					var oW, oH, cW, cH;
					oW = document.body.offsetWidth; //화면크기
					oH = document.body.offsetHeight;
					//alert(oH);	// 40
					cW = x + parseInt(options.width, 10) + 20;
					cH = y + parseInt(options.height, 10) + 5;	
					//alert(cH);		// 614		
					if(cW > oW) 
						x = x - (cW-oW);
					if(cH > oH) 
						y = y - (cH-oH);
					//alert("x:"+x+",y:"+y);
					x += window.screenLeft;
					y += window.screenTop;
					features += "dialogLeft:" + x + "px;dialogTop:" + y + "px;";
				} catch (e) {
					features += "center:on;";
				}
			} else if (options.pos == "absolute") {
				features += "dialogLeft:" + options.left + "px;dialogTop:" + options.top + "px;";
			} else {
				features += "center:on;";
			}
			features += "help:no;resizable:"+options.resizable+";status:no;scroll:no;unadorned:yes;";

			var title = "";
			if ( true ) {
				title = ($.browser.msie) ? encodeURIComponent(options.title) : options.title;
			}

			// https://developer.mozilla.org/en/DOM/window.showModalDialog
			if ( options.modal == "Y" ) {
				if($.browser.msie){
					rtnVal = window.showModalDialog(options.context+"/lib/page/modal.jsp?title="+title+"&scroll="+options.scroll, options, features);
				}else if($.browser.safari){	// 사파리 브라우저 따로 체크 - 서버경로를 인식 못함
					rtnVal = window.showModalDialog("http://${header.host}"+ options.context+"/common/modal.jsp?title="+title+"&scroll="+options.scroll, options, features);
				}else{
					rtnVal = window.showModalDialog(options.context+"/lib/page/modal.jsp?title="+title+"&scroll="+options.scroll, options, features);
				}
			} else {
				// TODO : Firefox에 showModelessDialog 없음.
				if($.browser.msie){
					rtnVal = window.showModelessDialog(options.context+"/lib/page/modal.jsp?title="+title+"&scroll="+options.scroll, options, features);
				}else{
					rtnVal = window.showModalDialog(options.context+"/lib/page/modal.jsp?title="+title+"&scroll="+options.scroll, options, features);
				}
			}
			if ( jQuery.isFunction(options.onClose) ) {
				options.onClose(rtnVal);
			}
			return rtnVal;
		}
	}
})(jQuery);


(function($) {
	$.fn.popupIframe = $.fn.popupiframe = function(s) {
		// This is only for IE6
		//if ( $.browser.msie && /6.0/.test(navigator.userAgent) ) {
			var obj = $(this);		
			s = $.extend({
				top     : 'auto', // auto == .currentStyle.borderTopWidth
				left    : 'auto', // auto == .currentStyle.borderLeftWidth
				right     : 'auto', // auto == .currentStyle.borderTopWidth
				bottom    : 'auto', // auto == .currentStyle.borderLeftWidth
				width   : 'auto', // auto == offsetWidth
				height  : 'auto', // auto == offsetHeight
				opacity : false,
				src     : 'about:blank'
			}, s || {});
			if ( s.width == "auto" ) s.width = obj.css("width");
			if ( s.height == "auto" ) s.height = obj.css("height");
			if ( s.top == "auto" ) s.top = obj.css("top");
			if ( s.left == "auto" ) s.left = obj.css("left");
			if ( s.right == "auto" ) s.right = obj.css("right");
			if ( s.bottom == "auto" ) s.bottom = obj.css("bottom");		
			var prop = function(n){return n&&n.constructor==Number?n+'px':n;},
			    html = '<iframe class="popupiframe" frameborder="0" tabindex="-1" src="'+s.src+'"'+
			               ' scrolling="no" style="display:block;position:absolute;z-index:0;'+
			               (s.opacity !== false?'filter:Alpha(Opacity=\'0\');':'')+
					       //'top:'+(s.top=='auto'?'expression(((parseInt(this.parentNode.currentStyle.borderTopWidth)||0)*-1)+\'px\')':prop(s.top))+';'+
					       //'left:'+(s.left=='auto'?'expression(((parseInt(this.parentNode.currentStyle.borderLeftWidth)||0)*-1)+\'px\')':prop(s.left))+';'+
					       'top:'+prop(s.top)+';'+
					       'left:'+prop(s.left)+';'+
					       'right:'+prop(s.right)+';'+
					       'bottom:'+prop(s.bottom)+';'+
					       'width:'+(s.width=='auto'?'expression(this.parentNode.offsetWidth+\'px\')':prop(s.width))+';'+
					       'height:'+(s.height=='auto'?'expression(this.parentNode.offsetHeight+\'px\')':prop(s.height))+';'+
						'"/>';
			//alert(html);
			return this.each(function() {
				if ( $('> iframe.popupiframe', this).length == 0 ) {
					$(this).before(html);
					
				}
			});
		//}
		return this;
	};
})(jQuery);

(function($) {
	jQuery.createPopup = function(params) {
		var oPopup = $("body").data("jQuery_oPopup");
		if ( oPopup && oPopup.isOpen ) return false;
		if ( !oPopup ) oPopup = window.createPopup();
		else oPopup.hide();
		
		var defaults = {
			currW: 0,
			currH: 0,
		    dynWinX: 0,	
	    	dynWinY: 0,
	    	pos: "relative",
	    	slideX: "right",
	    	slideY: "down",
	    	intervalId: "",
	    	callback: function linkCallback(selectedId) {closeWin();}
		};
		var params = $.extend(defaults, params);
	    if ( params.slideX == "left" ) {	// right to left
	        params.dynWinX = params.top+params.width;
	    }
	    if (params.pos == "relative") {
			params.left = event.x;
			params.top = event.y;
			params.dynWinX= params.left;	
			params.dynWinY= params.top;	
		} else {
			params.dynWinX= params.left;	
			params.dynWinY= params.top;			
		} 
		
	    oPopBody = oPopup.document.body;
	    oPopBody.style.backgroundColor = "#e8e8e8";
	    oPopBody.style.border = "solid #C0C0C0 1px";
	    oPopBody.innerHTML = "";		

	    var anymateWin = function(params){
	    	var timerTerm = 20;
	    	if ( params.slideX == "left" ) {
	        	params.dynWinX -= timerTerm;
	        }
	    	if ( params.slideY == "up" ) {
	        	params.dynWinY -= timerTerm;
	        }
	    	params.currW += timerTerm;
	    	params.currH += timerTerm;

	    	if ( params.currW > params.width ) {
	    		params.currW = params.width;
	    		if ( params.slideX == "left" ) {
	    			params.dynWinX = params.top;
	    		}
	    	}
	    	if ( params.currH > params.height ) {
	    		params.currH = params.height;
	    		if ( params.slideY == "up" ) {
	    			params.dynWinY = params.left-params.height;
	    	    }
	    	}
	    		
	    	oPopup.show(params.dynWinX, params.dynWinY, params.currW, params.currH, document.body);

	    	if ( params.intervalId!="" && params.width == params.currW && params.height == params.currH ) {
	    		oPopBody = oPopup.document.body;
	    		oPopBody.style.backgroundColor = "#ffffff";
	    		oPopBody.style.border = "solid #C0C0C0 4px";	// #525252
	    		var title = "제목";
	    		var bodyHTML = "<p>본문내용</p><p><a id=\"link1\" href=\"#\">링크1</a></p><p><a id=\"link2\" href=\"#\">링크2</a></p>";		
	    		var templateHTML = "";
	    		templateHTML += "<div id=\"TB_title\" style=\"background-color:#e8e8e8;width:100%;height:27px;font: 12px;\">";
	    		templateHTML += "<div id=\"TB_ajaxWindowTitle\" style=\"float:left;padding:7px 0 5px 10px;margin-bottom:1px;\">"+title+"</div>";
	    		templateHTML += "<div id=\"TB_closeAjaxWindow\" style=\"float:right;text-align:right;padding:7px 10px 5px 0;margin-bottom:1px;\"><a id=\"TB_closeWindowButton\" href=\"#\">닫기</a></div>";
	    		templateHTML += "</div>";
	    		templateHTML += "<div style=\"width:100%;height:100%;padding:5px 15px 15px 10px;overflow:auto;text-align:left;line-height:1.4em;font: 12px;\" id=\"TB_ajaxContent\">";
	    		templateHTML += bodyHTML;
	    		templateHTML += "</div>";
	    		templateHTML += "";
	    		//alert(templateHTML);
	    		
	    		
	    		oPopBody.innerHTML = templateHTML;
	    		window.clearInterval(params.intervalId);
	    		var aLinks = oPopup.document.getElementsByTagName("a");
	    		if ( aLinks && aLinks.length > 0 ) {
	    			for(var i=0;i<aLinks.length;i++) {
	    				aLinks[i].onclick = function() {
	    					params.callback(this.id);
	    				};
	    			}
	    		}
	    		var closeBtn = oPopup.document.getElementById("TB_closeWindowButton");
	    		closeBtn.onclick = closeWin;
	    	}
	    }	

	    var closeWin = function() {
	    	if ( oPopup ) oPopup.hide();
	    }

	    params.intervalId = window.setInterval(function(){anymateWin(params)},10);

		return oPopup;
	};
})(jQuery);

(function($) {
	// TODO : modal 처럼 동작하기, 부모 윈도우 얻어내는 방법 통일, 파라메타 얻는 방법 통일, 오픈시 효과주기
	jQuery.openWin = function(options) {
	  options = jQuery.extend({
	     url: null,
	     target: "_blank",
	     top: (screen.height) ? (screen.height-options.height)/2 : 0,
	     left: (screen.width) ? (screen.width-options.width)/2 : 0,
	     width: 300,
	     height: 300,
	     status: "no",
	     menubar: "no",
	     resizable: "yes",
	     scrollbars: "yes",
	     toolbar: "no", 
	     location: "no",
	     directories: "no",
	     method: "get"
	  }, options);
	  
	  if ( options.method == "post" ) {
	    
	  }

	  var params = "top="+options.top+", left="+options.left+", ";
	  params += "height="+options.height+", width="+options.width+", ";
	  params += "status="+options.status+", menubar="+options.menubar+", ";
	  params += "resizable="+options.resizable+", scrollbars="+options.scrollbars+", ";
	  params += "toolbar="+options.toolbar+", location="+options.location+", directories="+options.directories;
	  var newWin = window.open(options.url, options.target, params);  
	  newWin.focus();
	  return newWin;
	};  

})(jQuery);

(function($) {
	jQuery.popup = {
		modal: function(options) {
			return jQuery.modal(options);
		},
		modeless: function(options) {
			return jQuery.modeless(options);
		},
		createPopup: function(options) {
			return jQuery.createPopup(options);
		},
		openWin: function(options) {
			return jQuery.openWin(options);
		},

		getDialogArguments: function() {
			// Firefox에서는 첫 팝업 페이지에서만 dialogArguments 값을 얻을 수 있음
			return (!$.browser.msie) ? top.window.dialogArguments : window.dialogArguments;
		},
		getDialogParams: function() {
			// Firefox에서는 첫 팝업 페이지에서만 dialogArguments 값을 얻을 수 있음
			var arguemnts = jQuery.popup.getDialogArguments();
			return ( arguemnts == null || arguemnts.param == null ) ? {} :  arguemnts.param;
		},
		setReturnValue: function(value) {
			if($.browser.msie){
				parent.window.returnValue = value;
			}else{
				top.window.returnValue = value;
			}
		}
	}
})(jQuery);