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
 * @fileoverview <a href="http://www.hsnc.co.kr/solution/solution_a1.jsp" target="blank">이글오피스 전자결재</a> 작성 화면과의 연동 담당
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 2.0 
 */

/**
 * DraftWindow 객체 생성자
 * @class 결재 상신 팝업창을 띄우는데 사용되는 클래스
 * <br><br><I><b>example)</b></I>
 * <br>var ap = new hanwha.approval.DraftWindow();
 * <br>ap.init();
 * <br>ap.setService("LINKTEST");
 * <br>ap.addParam("title", "테스트");
 * <br>ap.addParam("name", "홍길동");
 * <br>ap.open();<br><br>
 * @constructor
 * @return A new DraftWindow
 * @author 박성수 <a href="mailto:ghbpark@hanwha.co.kr">ghbpark@hanwha.co.kr</a>
 * @version 2.0 
 */
 
hanwha.approval.DraftWindow = function DraftWindow() {
	this.CONTENT_BODY = "CONTENT_BODY_BY_FU";	// CONTENT_BODY를 나타내는 상수
	this.width = "1070";
	this.height = "760";
	this.isFullScreen = false;

	this.jsonDocument = "";
	
	this.service = "";
	this.params = "";
	this.attachLink = "";
	this.bodyLink = "";
	this.mode = "";
	
	this.map = new HashMap();
	this.setId("");
	this.setTitle("");
	this.setDocPortraitType(""); //horizontal : 가로양식 , vertical : 세로양식
	
	this.fileMap = new HashMap();
	this.setOtaId("");
};

hanwha.approval.DraftWindow.prototype = {

	/**
	 * 객체 초기화
	 */
	init : function(pDocElement) {
		
		if (pDocElement != null) {
			this.jsonDocument = pDocElement;
		}else {						
			this.jsonDocument = {
				"service" : this.service, 
				"params" : this.getParams(), 
				"attachLink" : this.attachLink, 
				"bodyLink" : this.bodyLink, 
				"mode" : this.mode
			};
		}
		
		this.addParam("client",client);
		this.addParam("debugFlag",debugFlag);
		this.addParam("alarmYn",alarmYn);
		this.addParam("viewYn",viewYn);

		this.addParam("agentCompanyId",agentCompanyId);
	},
	
	/**
	 * 인쇄시 가로, 세로 양식설정
	 * @param {String} portraitYn 인쇄시 가로,세로양식설정
	 */
	setDocPortraitType : function(docPortraitType) {		
		this.addParam("docPortraitType", docPortraitType);
	},
	
	getDocPortraitType : function() {
		var docPortraitType = this.map.get("docPortraitType");
		if(docPortraitType == null)
			docPortraitType = "vertical"; //horizontal : 가로양식 , vertical : 세로양식
	
		return docPortraitType;			
	},
	
	/**
	 * 결재문서 코드 지정, 실제로는 결재문서에 존재하는 결재선 코드명을 지정
	 * @param {String} serviceName 결재문서 서비스명
	 */
	setService : function(serviceName) {
		this.service = serviceName;
	},
	
	getService : function() {
		return this.service;			
	},

	/**
	 * 파라메타 추가
	 * @param {String} key 키
	 * @param {String} value 값
	 */
	addParam : function(key, value) {
		
		this.map.put(key, value);
	},
	
	/**
	 * 파라메타 변경(지정)
	 * @param {String} key 키
	 * @param {String} value 값
	 */
	setParam : function(key, value) {

		this.addParam(key, value);
	},	
	
	getParams : function() {
		var paramStr = this.map.toJSON();
		
		return $.evalJSON("[" + paramStr + "]");
	},

	/**
	 * CDATA 형식의 파라메타 추가
	 * @param {String} key 키
	 * @param {String} value 값
	 */
	addCDATAParam : function(key, value) {		


	},

	/**
	 * 본문 내용 지정, ex) "/test/sample.jsp?id=12345"
	 * @param {String} bodyURI 본문 경로
	 */
	setBody : function(bodyURI) {		
		this.bodyLink = bodyURI;
	},	

	/**
	 * 첨부파일 추가 (파일명, 파일경로)
	 * <br>ex) addAttachFile("회의록.doc", "C:/temp/2002132.doc");
	 * @param {String} fileName 파일명
	 * @param {String} filePath 파일경로
	 */
	addAttachFile : function(fileName, filePath) {
		
		this.fileMap.put(fileName, filePath);
		
		this.attachLink = $.evalJSON("[" + this.fileMap.toJSON() + "]");
	},

	/**
	 * 첨부파일 세팅
	 * <br><I><font color=red>NOTE</font></I> : 본 메소드는 Agent 내부적으로 사용되는 메소드 이므로 직접 호출하지 마십시오.
	 * @param {String} attachXML 첨부 XML
	 * @private
	 */
	setAttach : function(attachXML) {
		
	},

	/**
	 * 팝업창 사이즈 조정, 기본값 : 1000, 760
	 * @param {String} w 가로 크기
	 * @param {String} h 세로 크기
	 */
	setSize : function(w, h) {
		this.width = w;
		this.height = h;
	},

	/**
	 * 팝업창을 윈도우 전체 크기로 지정, 기본값 : false
	 * @param {boolean} fullScreen true or false
	 */
	setFullScreen : function(fullScreen) {
		this.isFullScreen = fullScreen;
	},

	/**
	 * 이벤트연동용 Host (이벤트발생시 호출을 받을 서버 Host)
	 * <br>기본값 : config.js의 callbackHost
	 * @param {String} cbHost Host
	 */
	
	setCallbackHost : function(cHost) {
		this.cbHost = cHost;
	},
	
	/**
	 * 이벤트연동용 Port (이벤트발생시 호출을 받을 서버 Port)
	 * <br>기본값 : config.js의 callbackPort
	 * @param {String} cPort Port
	 */
	
	setCallbackPort : function(cPort) {
		this.cbPort = cPort;
	},
	
	/**
	 * 이벤트연동용 Target (이벤트발생시 호출을 받을 URL)
	 * @param {String} cTarget Target
	 */
	
	setCallbackTarget : function(cTarget) {
		this.cbTarget = cTarget;
	},
	
	/**
	 * @private
	 */
	
	setCallback : function() {

	},
	
	/**
	 * @private 결재 아이디
	 */
	
	setId : function(id) {
		this.addParam("id", id);
	},

	getId : function() {
	
		var id = this.map.get("id");
		if(id == null)
			id = "";
	
		return id;			
	},

	/**
	 * @private 결재 타이틀
	 */
	 
	setTitle : function(title) {
		title = this.replaceSpecialChar(title);
		this.addParam("title", title);
	},
	
	getTitle : function() {
	
		var title = this.map.get("title");
		if(title == null)
			title = "";
	
		return title;			
	},

	/**
	 * 팝업창 띄우기
	 */
	open : function() {
		//alert("Open");		
		
		if(this.getService() == ""){
			alert("Service를 입력하여 주세요.");
			return;
		}

		if(this.getId() == ""){
			alert("결재아이디를 입력하여 주세요.");
			return;
		}
		
		//this.jsonDocument.params = this.getParams();
		this.init();

		var targetURL = agentRoot+"/lib/page/draft_with_slo.jsp";
		
		var obj = $.modal({
			url:targetURL,
			title: "Ready",
			param: {"p" : $.toJSON(this.jsonDocument), "host" : approvalHost, "port" : approvalPort},
			width: this.width,
			height: this.height,
			scroll: "yes",
			type : "POST",
			onClose: function (jsonObj) {
			}
		});
		
		return obj;
	},

	/**
	 * XML 객체를 얻음
	 * <br><I><font color=red>NOTE</font></I> : 본 메소드는 Agent 내부적으로 사용되는 메소드 이므로 직접 호출하지 마십시오.
	 * @private
	 */
	getJson : function() {
		return this.jsonDocument;
	},

	/**
	 * XML 객체에 담긴 내용을 String 형태로 출력
	 * <br><I><font color=red>NOTE</font></I> : 본 메소드는 Agent 내부적으로 사용되는 메소드입니다. Debug 용도가 아니라면 사용하지 마십시오.
	 * @return XML 객체 내용
	 * @type String
	 */
	toString : function() {
		this.init();
		this.jsonDocument.params = this.getParams();
		return $.toJSON(this.jsonDocument);
	},
	
	setMode : function(modestr) {
		this.mode = modestr;
	},
	
	replaceSpecialChar : function(val) {
		val = val.replace(/['']/gi, "′");
		val = val.replace(/[""]/gi, "″");
		val = val.replace(/[&]/gi, "＆");
		val = val.replace(/[<]/gi, "＜");
		val = val.replace(/[>]/gi, "＞");
		val = val.replace(/[*]/gi, "＊");
		val = val.replace(/[:]/gi, "：");
		val = val.replace(/[|]/gi, "ː");
		val = val.replace(/[\\]/gi, "￦");
		val = val.replace(/[\/]/gi, "／");
		val = val.replace(/[?]/gi, "？");
		val = val.replace(/[#]/gi, "＃");
		val = val.replace(/[']/gi, "′");
		return val;
	},
	
	setOtaId : function(otaId) {
		this.addParam("slo_p_ota", otaId);
	}
};
