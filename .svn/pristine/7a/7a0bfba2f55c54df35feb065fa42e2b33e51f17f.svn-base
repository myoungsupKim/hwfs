bizwell.commons.PostConnection = function PostConnection(ecName) {
	this.name = ecName;
	this.targetForm = null;
	this._connInit = false;
	this.method = 'POST';
	this.postConnIFRAME = ecName+'_postConnIFRAME';
	this.postConnDIV 	= ecName+'_postConnDIV';
	this.postConnForm = ecName+'_postConnForm';
	this.callback = false;

	this.responseText = null;
	this.responseHTML = null;
	this.responseXML = null;	
	
	this.status = 0;
	this.statusMessage = "";
	
	this.responseType = "text";

	this.apXmlDoc = null; 
	this.apElement = null;

	this.debug = false;
};

bizwell.commons.PostConnection.prototype = {

	/**
	 * 객체 초기화
	 */
	init : function(tform) {
		this._connInit = false;
		this.targetForm = null;
		this.responseType = "text";

		var iframeHTML = '<iframe name="'+this.postConnIFRAME+'" onload="'+this.name+'.processPostConn(this);" style="display:none"></iframe>';
		
		var divHTML = '<div id="'+this.postConnDIV+'" style="display:none"></div>';
		var postConnDIVObj = document.getElementById(this.postConnDIV);
		if ( postConnDIVObj != null ) {
			postConnDIVObj.innerHTML = '';
		} else {
			document.getElementsByTagName("body").item(0).insertAdjacentHTML('afterBegin', divHTML);
			//document.body.insertAdjacentHTML('afterBegin', divHTML);
			postConnDIVObj = document.getElementById(this.postConnDIV);
		}
		postConnDIVObj.innerHTML = iframeHTML;
		
		//document.body.insertAdjacentHTML('beforeEnd', iframeHTML);
		
		if ( tform != null ) {
			this.setForm(tform);
		}
		
		this.responseText = null;
		this.responseHTML = null;
		this.responseXML = null;

		this.status = 0;
		this.statusMessage = "";
		
		this.callback = false;
		
		this.callbackMethod = this.callbackHandler;
		
		this.apXmlDoc = null; 
		this.apElement = null;	

		this.debug = false;
	},

	/**
	 * 호출 결과 세팅
	 * @private
	 */
	setStatus : function(code, msg) {
		this.status = code;
		this.statusMessage = msg;
	},

	/**
	 * @private
	 */
	callbackHandler : function(code) {
	},

	/**
	 * callback 메소드 지정
	 * @param {function} cb callback function
	 */
	setCallback : function(cb) {
		this.callbackMethod = cb;
		this.callback = true;
	},

	/**
	 * @private
	 */
	setDebug : function(value) {
		this.debug = value;
		/*
		if ( this.debug )
		{
			var objBody = document.getElementsByTagName("body").item(0);
			if ( !document.getElementById('_'+this.name+'debugcontainer') )
			{
				var debugWindowHTML;
				debugWindowHTML = '<div align="center" id="_'+this.name+'debugcontainer" style="VISIBILITY:  hidden;position:absolute;z-index:3;left:400px;top:300px;">';
				debugWindowHTML += '	<table align="center" width="800" cellspacing="0" cellpadding="0">';
				debugWindowHTML += '		<tr>';
				debugWindowHTML += '			<td style="background-color :#575757;" align="center" onclick="'+this.name+'.hideDebugWindow();">';
				debugWindowHTML += '				close this window';
				debugWindowHTML += '			</td>';
				debugWindowHTML += '		</tr>';
				debugWindowHTML += '	</table>';
				debugWindowHTML += '	<table align="center" width="800" cellspacing="0" cellpadding="0">';
				debugWindowHTML += '		<tr>';
				debugWindowHTML += '			<td style="background-color :#575757;" align="center">';
				debugWindowHTML += '				<table width="800" style="background-color:#ffffff; padding:5px;margin:5px;border:1px solid #cecece;border-bottom:2px solid #9e9e9e;border-right:1px solid #9e9e9e;">';
				debugWindowHTML += '					<tr>';
				debugWindowHTML += '						<td id="_'+this.name+'debugcontent">';
				debugWindowHTML += '						</td>';
				debugWindowHTML += '					</tr>';
				debugWindowHTML += '				</table>';
				debugWindowHTML += '			</td>';
				debugWindowHTML += '		</tr>';
				debugWindowHTML += '	</table>';
				debugWindowHTML += '</div>';

				objBody.insertAdjacentHTML("beforeEnd", debugWindowHTML);
			}
		}
		*/
	},

	/**
	 * @private
	 */
	showDebugWindow : function() {
		/*
		if ( this.responseXML )
		{
			document.all('_'+this.name+'debugcontent').innerText = this.responseXML.xml;
		} else ( this.responseXML )
		{
			document.all('_'+this.name+'debugcontent').innerHTML = this.responseHTML;
		}
		
		sc_ie=document.all('_'+this.name+'debugcontainer');
		sc_ie.style.left=document.body.scrollLeft+document.body.clientWidth/2-sc_ie.offsetWidth/2;
		sc_ie.style.top=document.body.scrollTop+document.body.clientHeight/2-sc_ie.offsetHeight/2;
		sc_ie.style.visibility = "visible";
		sc_ie.style.zIndex = '110';
		*/
		//if ( !this.debug ) return;

		var debugWin = window.open('about:blank',"_blank","height=600,width=800,status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=yes,titlebar=no");
		if ( this.responseXML )
		{
			debugWin.document.write(this.responseXML.xml);
		} else ( this.responseXML )
		{
			debugWin.document.write(this.responseHTML);
		}
		
	},

	/**
	 * @private
	 */
	hideDebugWindow : function() {
		sc_ie=document.all('_'+this.name+'debugcontainer');
		sc_ie.style.visibility="hidden";	
	},

	/**
	 * @private
	 */
	processPostConn : function(eagleResponseFrame) {
		if ( this._connInit ) {
			try {
				var responseDocument = eagleResponseFrame.contentWindow.document;	
				if ( responseDocument ) {
					if ( responseDocument.documentElement ) {
						try {
							this.responseText = responseDocument.documentElement.innerText;
							if ( this.isNotNull(this.responseText) ) {
								this.status = 1;
							}
						} catch (e) {}
						try {
							this.responseHTML = responseDocument.documentElement.innerHTML;
							if ( this.isNotNull(this.responseHTML) ) {
								this.status = 1;
							}
						} catch (e) {}
					} 
					if ( responseDocument.XMLDocument ) {
						try {
							this.responseXML = responseDocument.XMLDocument;
							if ( this.isNotNull(this.responseXML) ) {
								this.status = 1;
							}
						} catch (e) {}
					}
					
					try {
						// 임의로 추가한 히든값 삭제
						if ( this.apElement != null ) {
							/*
							alert("verify.." + this.apElement.xml);

							var itemsElement = this.apXmlDoc.documentElement.singleNodes("//item");
							alert(itemsElement);
							alert("itemsElement.length : " + itemsElement.length);
							for(i=0; i<itemsElement.length; i++) {
								var targetElementName = itemsElement.item(i).name;
								var delTarget = this.targetForm.getElementById(targetElementName);
								alert("delTarget : " + delTarget);
								//document.getElementById(targetElementName);
							}
							*/
							/*
							var tChildNodes = this.targetForm.childNodes;
							for(i=0; i<tChildNodes.length; i++) {
								var name = tChildNodes.item(i).name;
								var itemsElement = this.apElement.selectSingleNode("//item[@name='"+name+"']");
								//alert(itemsElement);
								//if ( itemsElement ) tChildNodes.item(i).removeNode(true);
								if (itemsElement != null)
								{
									//alert("here..");
									tChildNodes.item(i).removeNode(true);
									//var targetDelNode = tChildNodes.item(i);
									//targetDelNode.parentNode.removeChild(targetDelNode);
								}
							}
							*/
						}	
					} catch (e) {
						//alert(e.description);
					}
					
					if ( this.status != 0 ) {
						this.callbackMethod(this.status);
					}
				} else {
					this.setStatus(-2, "응답내용이 없습니다");
				}
			} catch (e) {
				this.setStatus(-1, e.description);
			}
		}
	},

	/**
	 * @private
	 */
	isNotNull : function(txt) {
		return ( txt != null && txt != 'null' && txt != '<HEAD></HEAD><BODY></BODY>' )
	},

	/**
	 * 파라메타 추가
	 * @param {String} name 키
	 * @param {String} value 값
	 */
	addParam : function(name, value) {
		if ( this.apXmlDoc == null ) {
			this.apXmlDoc = new ActiveXObject("Msxml2.DOMDocument");
			this.apElement = this.apXmlDoc.createElement("params");	
		}
		
		var itemElement = this.apXmlDoc.createElement("item");
		itemElement.setAttribute("name", name);
		itemElement.text = value;	
		
		this.apElement.appendChild(itemElement);
	},

	/**
	 * CDATA 형식의 파라메타 추가
	 * @param {String} name 키
	 * @param {String} value 값
	 */
	addCDATAParam : function(name, value) {
		if ( this.apXmlDoc == null ) {
			this.apXmlDoc = new ActiveXObject("Msxml2.DOMDocument");
			this.apElement = this.apXmlDoc.createElement("params");	
		}
		
		var itemElement = this.apXmlDoc.createElement("item");
		itemElement.setAttribute("name", name);
		//itemElement.text = value;	
		var cDataValue = this.apXmlDoc.createCDATASection(value);
		itemElement.appendChild(cDataValue);
		
		this.apElement.appendChild(itemElement);
	},

	/**
	 * Array 형식의 파라메타 추가
	 * @param {String} name 키
	 * @param {String} value 값
	 */
	addParams : function(name, value) {
		if ( this.apXmlDoc == null ) {
			this.apXmlDoc = new ActiveXObject("Msxml2.DOMDocument");
			this.apElement = this.apXmlDoc.createElement("params");	
		}
		
		var itemsElement = this.apElement.selectSingleNode("//items[@name='"+name+"']");
		if ( itemsElement != null ) {
			var valueElement = this.apXmlDoc.createElement("value");
			valueElement.text = value;
			itemsElement.appendChild(valueElement);
		} else {
			itemsElement = this.apXmlDoc.createElement("items");
			itemsElement.setAttribute("name", name);
			var valueElement = this.apXmlDoc.createElement("value");
			valueElement.text = value;
			itemsElement.appendChild(valueElement);
			this.apElement.appendChild(itemsElement);
		}
	},

	/**
	 * post 요청시 사용할 form 지정 (지정하지 않을 경우 자동으로 form 생성해서 요청함)
	 * @param {form} tform 폼
	 */
	setForm : function(tform) {
		this.targetForm = tform;
		this.targetForm.method = this.method;
	},

	/**
	 * 가상 폼 생성
	 * @private
	 */
	createVirtualForm : function() {
		var postConnDIVObj = document.getElementById(this.postConnDIV);
		
		var formElement = document.createElement("form");
		formElement.name = this.postConnForm;
		postConnDIVObj.appendChild(formElement);
		
		this.setForm(formElement);
	},

	/**
	 * 요청을 보냄
	 * @param {String} targetURI 요청을 보낼 URI
	 */
	send : function(targetURI, cb) {
		if ( cb != null ) {
			this.setCallback(cb);
		}
		
		if ( this.targetForm == null ) {
			this.createVirtualForm();
		}
		
		var targetIdx = targetURI.indexOf('?');
		
		if ( targetIdx > 1 ) {
			var _uri = targetURI.substring(0, targetIdx);
			var _qs = targetURI.substring(targetIdx+1, targetURI.length);
			targetURI = _uri;
			var args = _qs.split('&');
			for (var i=0; i<args.length; i++) {
				var value;
				var pair = args[i].split('=');
				var name = pair[0];
				if (pair.length == 2) {
					value = pair[1];
				}
				this.addParam(name, value);
			}
		}	
		
		if ( this.apElement != null ) {
			var pChildNodes = this.apElement.childNodes;
			for(i=0; i<pChildNodes.length; i++) {
				var pChildNode = pChildNodes.item(i);
				var pChildName = pChildNode.getAttribute("name");
				if ( pChildNode.nodeName == 'item' ) {
					/*
					var arrPreHDObj = document.getElementsByName(pChildName);
					//alert(arrPreHDObj);
					if(arrPreHDObj != null && arrPreHDObj.length > 0 ) {
						alert("
						for(j=0; j<arrPreHDObj.length; j++) {
							arrPreHDObj.item(j).removeNode(true);
						}
					}
					//alert(preHDObj);
					*/
					/*
					var preHDObj = document.getElementById(pChildName);
					if(preHDObj != null) {
						preHDObj.value = pChildNode.text;
					} else {
						var hiddenElement = document.createElement("input");
						hiddenElement.type = "hidden";
						hiddenElement.id = pChildName;
						hiddenElement.name = pChildName;
						hiddenElement.value = pChildNode.text;
						this.targetForm.appendChild(hiddenElement);

					}
					*/
					var preHDObj = document.getElementById(pChildName);
					if(preHDObj != null) {
						//preHDObj.value = pChildNode.text;
						try	{
							this.targetForm.removeChild(preHDObj);
						} catch (e) {}
					} 
					var hiddenElement = document.createElement("input");
					hiddenElement.type = "hidden";
					hiddenElement.id = pChildName;
					hiddenElement.name = pChildName;
					hiddenElement.value = pChildNode.text;
					this.targetForm.appendChild(hiddenElement);
				} else {
					/*
					var valueChildNode = pChildNode.childNodes;
					for(j=0; j<valueChildNode.length; j++) {
						var hiddenElement = document.createElement("input");
						hiddenElement.type = "checkbox";
						hiddenElement.name = pChildName;
						hiddenElement.value = valueChildNode(j).text;
						hiddenElement.checked = true;
						this.targetForm.appendChild(hiddenElement);
					}
					*/				
					var selectComponent = '<select style="display:none" name="' + pChildName + '" multiple>';
					var valueChildNode = pChildNode.childNodes;
					for(j=0; j<valueChildNode.length; j++) {
						selectComponent += '<option value="'+valueChildNode(j).text+'" selected>'+valueChildNode(j).text+'</option>';
					}				
					selectComponent += '</select>';
					this.targetForm.insertAdjacentHTML('beforeEnd', selectComponent);
				}
			}
		}
		this.targetForm.action = targetURI;
		if ( this.callback ) {
			this.targetForm.target = this.postConnIFRAME;
		} else {
			this.targetForm.target = "this";
		}
		this._connInit = true;
		this.targetForm.submit();
	}

};