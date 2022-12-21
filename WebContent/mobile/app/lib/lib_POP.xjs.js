//XJS=lib_POP.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        /*
         ● gfn_POP_create : 팝업을 생성
         ● gfn_POP_close : 팝업을 닫음
         ● gfn_POP_resize : 팝업의 크기 조정
         ● gfn_POP_getArg : 팝업 생성 시 전달된 argument를 구함
         ● background_onclick : 바탕(검은색반투명) 클릭 시 팝업이 닫히게 함
         ● addInfo : 팝업 정보를 저장
         ● getCallback : 콜백 함수을 얻어옴
         ● getParent : 팝업의 부모를 얻어옴
         ● getPopType : 팝업의 타입을 구함
         ● delInfo : 팝업 정보 삭제
         */

        this.argPop = undefined; //팝업 생성 시 전달된 argument
        this.dsInfo_POP = undefined; //팝업 정보 저장 (dataset)
        this.bDraw = true; //팝업을 다 그렸는지 여부

        

        /**
         * @desc   : 팝업 생성
         * @param  : id : 팝업을 구분짓는 id (필수)
         url : 팝업으로 띄워지는 form url (필수) or 팝업으로 띄위질 div (id는 반드시 divPOP_id로 명명되어야함)  - coolmind 2012.11.28 변경
         callback : 팝업이 닫힐 때 불려질 콜백함수명 (선택)
         callbackRcv : 콜백함수가 불려질 form의 path (callback가 있으면 필수)
         arg : 팝업으로 띄워질 form에 전달할 argument (선택)
         type : 팝업의 타입 (선택)
         POP : 팝업으로 띄워지는 form의 크기만큼 생성
         POP2 : POP으로 띄워지는 위치에서 오른쪽아래방향으로 20pixel 씩 이동해서 띄워짐 (2depth menu를 표현)
         POPx or POP2x : 바탕(검은색반투명) 클릭 시 팝업이 닫힘
         FULL : 부모의 크기만큼 팝업이 만들어짐 (바탕 생성 안함)
         POPDivx or POP2Divx : Div를 동적으로 생성하지 않고, 지정한 Div를 띄움 - coolmind 2012.11.28 추가
         
         parent : 팝업의 부모(container) (필수)
         * @return : 없음
         */
        this.gfn_POP_create = function (id,url,callback,callbackRcv,arg,type,parent)
        {
        	if (application.goMainSub.divMain.url == "frame::CmmnFrameSub.xfdl")
        	{
        		if (application.goMainSub.divMain.divWork.url == "M_MES::SurroundWorkplaceView.xfdl")
        		{
        			application.goMainSub.divMain.divWork.Map00.set_width(0);
        		}
        	}
        	
        	//frameBase 에 있는 fo_hisPOP array 에 popup 정보 추가 
        	trace("--- fo_hisPOP.push : " + id);
        	
        	if(id == "Login")
        	{
        		application.goMain.loginFlag = "Y";
        	}
        	else if(id == "errorId" || id == "errorPw" || id == "alertLogin" || id == "exit")
        	{
        		application.goMain.loginPopFlag = "Y";
        	}
        	else
        	{
        		application.goMain.loginFlag = "N";
        	}
        	
        	//application.goMain.fo_hisPOP.push(id);
        	
        	// trace("bDraw : " + bDraw);
        	// if (bDraw == false)
        	// return;

        	this.bDraw = false;

        	/* 기본값 -----------------------------------------------*/
        	if (application.gfn_IsNull(parent)) 
        	{
        		parent = this.getOwnerFrame().form;
        	}

        	if (application.gfn_IsNull(type)) 
        	{
        		type = "POP";
        	}
        	/*--------------------------------------------------------*/
        	if (type == "POPDivx") 
        	{
        		// coolmind 2012.11.28 변경
        		if (url.visible) 
        		{
        			return;
        		}
        		// coolmind 2012.11.29 - 동일한 것이 팝업되어 있으면 팝업하지 않도록 수정함
        	}
        	else 
        	{
        		if (!application.gfn_IsNull(parent.components["divPOP_" + id])) 
        		{
        			return;
        		}
        		// coolmind 2012.11.29 - 동일한 것이 팝업되어 있으면 팝업하지 않도록 수정함
        	}	
        	
        	application.goMain.fo_hisPOP.push(id);
        	
        	/* argument 저장 -----------------------------------------*/
        	if (!application.gfn_IsNull(arg)) 
        	{
        		this.argPop = arg;
        	}
        	else 
        	{
        		this.argPop = "";
        	}
        	/*---------------------------------------------------------*/

        	this.addInfo(id, callback, callbackRcv, parent, type);

        	/* Static 생성 -------------------------------------------*/
        	var objStatic = null;
        	if (type != "FULL") 
        	{
        		if (!application.gfn_IsNull(parent.components["staPOP_" + id])) 
        		{
        			return;
        		}

        		//objStatic = new Static("staPOP_" + id, "absolute", 0, 0, parent.getOffsetWidth() - 0, parent.getOffsetHeight() - 0);
        		//단말에서 확인필요
        		objStatic = new Static("staPOP_" + id, "absolute", 0, 0, null, null, 0, 0);
        		//20140507 팝업 배경 사이즈 조절 아이폰 4, 4s 문제
        		//objStatic = new Static("staPOP_" + id, "absolute", 0, 0, null, null, -10, -200);
        		objStatic.style.set_border_width(0);
        		objStatic.style.set_background_color("#000000bb");

        		parent.addChild(objStatic.name, objStatic);
        		objStatic.show();

        		// if (type == "POPx")
        		if (type.charAt(type.length - 1) == "x") 
        		{
        			objStatic.addEventHandler("onclick", this.background_onclick, this);
        		}
        	}
        	/*---------------------------------------------------------*/

        	/* Div 생성 -----------------------------------------------*/
        	var div;

        	if (type == "POPDivx") 
        	{
        		// coolmind 2012.11.28 변경
        		div = url;
        	}
        	else 
        	{
        		div = new Div("divPOP_"+id);
        		parent.addChild("divPOP_"+id, div);

        	}

        	// 20150120 POPDivx일 경우에 처리가 안되어 있어 추가함
        	if (type == "POPDivx")
        	{
        		div.set_visible(true);
        		div.bringToFront();		
        	}
        	else
        	{
        		div.set_visible(false);
        	}
        	
        	// v13에서 애니메이션이 동작하지 않는 문제가 있어
        	// 아래쪽에 있던 코드를 이쪽으로 이동함
        	div.show();
        	//----------------------------------------------------
        	
        	div.style.set_border_width(0);

        	if (type != "FULL" && type != "USER") 
        	{
                //20140430 주석
        		//div.style.set_bordertype("round 10 10");
        		//div.shadow = "outer 5,5 5 #222222";
        		div.style.set_background("#f2f2f2ff");
        	}
        	else if (type == "FULL") 
        	{
        		//div.positiontype = "position2";
        		//div.__setPosition9x("absolute l:0 t:0 r:0 b:0");
        // 		div.setOffsetLeft(0);
        // 		div.setOffsetTop(0);
        // 		div.setOffsetRight(0);
        // 		div.setOffsetBottom(0);
        //20140422 주석 가이드
        		div.position = "absolute";
        		div.set_left(0);
        		div.set_top(0);
        		div.set_right(0);
        		div.set_bottom(0);
        		
        		// div.position2 = "absolute l:0 t:" +parent.vscrollbar.pos+" r:0 b:0";
        		// div.position.y = parent.vscrollbar.pos;
        		// trace(div.positiontype);
        		// trace(div.position);
        		// trace(div.position2);
        		// parent.vscrollbar.pos = 0;
        	}

        	if (type == "USER") 
        	{
        		div.set_cssclass("div_opacity");
        	}
        	
        	if (type != "POPDivx") 
        	{
        		div.set_url(url);
        	}
        	
        	if (type == "POPDivx") 
        	{
        		// coolmind 2012.11.28 변경
        		div.userCallbackid = id; //coolmind 2012.11.30 - 생성한 div에 userCallbackid라는 User Property를 추가함
        		objStatic.userDivname = div.name; //coolmind 2012.11.30 - 생성한 Static에 userDivname라는 User Property를 추가함

        		// div.fnFormInit(); //화면에 초기값을 설정하는 공통함수 호출 (필수)
        		div.bringToFront();
        	}
        	
        	div.set_scrollbars("autovert");
        	this.bDraw = true;

        	// parent.scrollbars = "none";
        	// if (type != "FULL")
        	// gfn_POP_resize(div, type);
        }

        /**
         * @desc   : 팝업 종료
         * @param  : obj : 팝업으로 띄워진 form (필수)
         띄워진 form에서 호출하기 때문에 무조건 this
         rtn : 팝업이 닫히면서 전달할 값
         bClose : false 인 경우 콜백함수를 호출하지 않음
         * @return : 없음
         */
        this.gfn_POP_close = function (obj,rtn,bClose)
        {
        	if (application.goMainSub.divMain.url == "frame::CmmnFrameSub.xfdl")
        	{
        		if (application.goMainSub.divMain.divWork.url == "M_MES::SurroundWorkplaceView.xfdl")
        		{
        			application.goMainSub.divMain.divWork.Map00.set_width(522);
        		}
        	}
        	
        	var objPOP = obj;

        	if (application.gfn_IsNull(objPOP)) 
        	{
        		objPOP = this;
        	}
        	
        	var id = objPOP.name.substr(7, objPOP.name.length - 7);
        	trace("userCallbackid>>"+obj.userCallbackid);
        	if (!application.gfn_IsNull(obj.userCallbackid)) 
        	{
        		if (obj.userCallbackid != id) 
        		{
        			id = obj.userCallbackid;
        		}
        		// "POPDivx"으로 팝업한것은 다르고 그외는 id와 userCallbackid가 같다
        	}
        	trace("id :: "+id);
        	if (arguments.length <= 2) 
        	{
        		bClose = true;
        	}

        	var cb = this.getCallback(id);
        	var parent = this.getParent(id);

        	var lastSpotIdx = parent.lastIndexOf(".");
        	if (lastSpotIdx > 0) 
        	{
        		parent = parent.substr(0, lastSpotIdx);
        	}		
        	
        	trace("parent >>> " + parent);
        	parent = eval(parent);
        	trace("parent >>> " + parent.name);
        	if (rtn != "CLOSEONLY") 
        	{
        		if (cb[0] != null && cb[0].length > 0) 
        		{
        			var strFunc = cb[1] + cb[0] + "('" + id + "', rtn)";
        			trace("strFunc >>> " + strFunc);
        			eval(strFunc);
        		}
        	}

        	if (bClose == true) 
        	{
        		// parent.scrollbars = "autoboth";
        		var sType = this.getPopType(id);
        		this.delInfo(id);

        		if (application.gfn_IsNull(parent)) 
        		{
        			return;
        		}

        		var arrObj;
        		arrObj = new Array(2);

        		arrObj[0] = parent.removeChild("staPOP_" + id);
        		if (sType == "POPDivx") 
        		{
        			// coolmind 2012.11.28 변경
        			// parent.components["divPOP_"+id].visible = false; // coolmind 2012.11.28 변경
        			objPOP.set_visible(false);
        		}
        		else 
        		{
        			arrObj[1] = parent.removeChild("divPOP_" + id);
        		}

        		application.goPopDestroy = arrObj;

        //		this.lookup("form").setTimer(application.gi_timerID_PopDestroy, 100);

        		this.getOwnerFrame().form.setTimer(application.gvTimerID_PopDestroy, 100); 
        		
        		//-> 오류발생 무시. app종료후 timer가 돌아서 오류나는 것으로 보임. milpaso comment
        		//: uxs (7268): App Error#1 [0x85000001] [object Application]:TypeError: Cannot call method 'setTimer' of null
        		//at line 308, in function: gfn_POP_close in file://D:/_V13Generate/LGMCS_V13/LIB/lib_POP.xjs.js
        		
        		// this.lookup("fo_hisPOP").pop(); // Runtime 전환 시 오작동으로 절대값 위치로 변경  20150730 김광호
        		application.goMain.fo_hisPOP.pop();
        		
        	}
        }

        /**
         * @desc   : 팝업으로 띄워진 form 의 onload에서 필수로 불려야 함
         ajax에서 Div.url로 인한 onload의 발생 시점이 느려 Div.url 이후 코드가 먼저 실행이 됨
         * @param  : obj : 팝업으로 띄워진 form (필수)
         띄워진 form에서 호출하기 때문에 무조건 this
         * @return : 없음
         */
        this.gfn_POP_resize = function (obj ,nTop)
        {
        	var id = obj.name.substr(7, obj.name.length - 7);
        	if (!application.gfn_IsNull(obj.userCallbackid)) 
        	{
        		if (obj.userCallbackid != id) 
        		{
        			id = obj.userCallbackid;
        		}
        		// "POPDivx"으로 팝업한것은 다르고 그외는 id와 userCallbackid가 같다
        	}

        	var type = this.getPopType(id);

        	if (application.gfn_IsNull(type)) 
        	{
        		return;
        	}
        	// coolmind 2012.11.29 - 파업화면을 위한 div를 미리 생성해 화면을 메모리 로드하는 방식을 위한 예외처리

        	if (type == "FULL") 
        	{
        		obj.set_visible(true);
        		return;
        	}

        	var parentW = obj.parent.getOffsetWidth();
        	var parentH = obj.parent.getOffsetHeight();
        	var formW = obj.staFormSize.getOffsetWidth();
        	var formH = obj.staFormSize.getOffsetHeight();
        	trace("--- 1 gfn_POP_resize parentW["+parentW+"] parentH["+parentH+"]");
        	trace("--- 1 gfn_POP_resize formW["+formW+"] formH["+formH+"]");

        	// 2012.05.08 milpaso - 공통메세지 처리 S -------------------
        	// Div border에 따라 formW, formH 를 + 해줘야 함(송영준)
        	// -> Div에 border를 준 후 Div사이즈와 링크폼 사이즈가 같으면 스크롤바가 생겨버림.
        	// div사이즈를 border사이즈만큼 크게 처리함.
        	
        // 	formW += obj.style.border.width * 2;
        // 	formH += obj.style.border.width * 2;
        //20140430 주석
        //	formW += parseInt(obj.currentstyle.border.width) * 2;
        // 	formH += parseInt(obj.currentstyle.border.width) * 2;
        	
        	// 2012.05.08 milpaso - 공통메세지 처리 E -------------------

        	var menu2 = 0;
        	if (type.indexOf("POP2") >= 0) 
        	{
        		menu2 = 20;
        	}

        	var l,t,r,b;

        	l = (formW >= parentW) ? 0 : (parentW - formW) / 2;
        	l += menu2;
        	if(!application.gfn_IsNull(nTop))
        	{
        		t = nTop;
        	}
        	else
        	{
        		t = (formH >= (parentH - 10 * 2)) ? 10 : (parentH - formH) / 2;
        	}
        	t += menu2;
        	r = (formW >= parentW) ? parentW : l + formW;
        	b = (formH >= (parentH - 10 * 2)) ? parentH - 10 : t + formH;

        	l = Math.round(l);
        	t = Math.round(t);
        	r = Math.round(r);
        	b = Math.round(b);

        	trace("l : " + l);
        	trace("t : " + t);
        	trace("r : " + r);
        	trace("tt : " + b);
        //	obj.move(l, t, r - l, b - t);
        	obj.move(l, t, r - l, b - Math.round(t));
        	
        	//obj.resetScroll();
        	obj.set_visible(true);
        	obj.set_scrollbars("autovert");
        	obj.resetScroll();
        }

        /**
         * @desc   : 팝업으로 띄워진 form에서 전달된 argument 값을 가져오기 위한 함수
         * @param  : 없음
         * @return : argument
         */
        this.gfn_POP_getArg = function ()
        {
        	return this.argPop;
        }

        /**
         * @desc   : 바탕(검은색반투명) 클릭 시 팝업이 닫히게 함
         * @param  :
         * @return : 없음
         */
        this.background_onclick = function (obj,e)
        {
        	if (this.bDraw == false) 
        	{
        		return;
        	}
        	
        	if (application.goMainSub.divMain.url == "frame::CmmnFrameSub.xfdl")
        	{
        		if (application.goMainSub.divMain.divWork.url == "M_MES::SurroundWorkplaceView.xfdl")
        		{
        			application.goMainSub.divMain.divWork.Map00.set_width(522);
        		}
        	}

        	var id = obj.name.substr(7, obj.name.length - 7);

        	var divName = "divPOP_" + id;

        	if (!application.gfn_IsNull(obj.userDivname)) 
        	{
        		if (obj.userDivname != divName) 
        		{
        			divName = obj.userDivname;
        		}
        		// "POPDivx"으로 팝업한것은 다르고 그외는 id와 userDivname가 같다
        	}

        	var objParent = obj.parent;
        	var sType = this.getPopType(id);
        	this.delInfo(id);
        	
        	application.goMain.fo_hisPOP.pop();
        	
        	objParent.removeChild(obj.name);
        	if (sType == "POPDivx") 
        	{
        		objParent.components[divName].set_visible(false);
        	}
        	// coolmind 2012.11.28 변경
        	else 
        	{
        		objParent.removeChild(divName);
        	}
        }

        /**
         * @desc   : 팝업 정보를 저장
         * @param  : gfn_POP_create 시 넘어온 값과 동일
         * @return : 없음
         */
        this.addInfo = function (id,callback,callbackRcv,parent,type)
        {
        	trace("---   addInfo   ---");
        	if (application.gfn_IsNull(this.dsInfo_POP)) 
        	{
        		this.dsInfo_POP = new Dataset();
        		this.dsInfo_POP.set_name("dsInfo_POP");
        		this.dsInfo_POP.addColumn("id", "string");
        		this.dsInfo_POP.addColumn("callback", "string");
        		this.dsInfo_POP.addColumn("callbackObj", "string");
        		this.dsInfo_POP.addColumn("parent", "string");
        		this.dsInfo_POP.addColumn("type", "string");
        	}
        	
        	var row = this.dsInfo_POP.addRow();
        	this.dsInfo_POP.setColumn(row, "id", id);
        	this.dsInfo_POP.setColumn(row, "callback", callback);
        	this.dsInfo_POP.setColumn(row, "callbackObj", application.gfn_getObjPath(callbackRcv));
        	this.dsInfo_POP.setColumn(row, "parent", application.gfn_getObjPath(parent));
        	this.dsInfo_POP.setColumn(row, "type", type);
        }

        /**
         * @desc   : 콜백 함수을 얻어옴
         * @param  : id : 팝업 ID
         * @return : arr[0] : 콜백 함수명
         arr[1] : 콜백 함수가 불려질 form의 path (마지막에 .이 있다.)
         */
        this.getCallback = function (id)
        {
        	if (application.gfn_IsNull(this.dsInfo_POP)) 
        	{
        		return;
        	}

        	var arr = new Array();
        	arr[0] = this.dsInfo_POP.lookup("id", id, "callback");
        	arr[1] = this.dsInfo_POP.lookup("id", id, "callbackObj");

        	if (arr[0] == null || arr[1] == null) 
        	{
        		return;
        	}

        	return arr;
        }

        /**
         * @desc   : 팝업의 부모를 얻어옴
         * @param  : id : 팝업 ID
         * @return : 부모가 되는 container의 path (마지막에 .이 있다.)
         */
        this.getParent = function (id)
        {
        	trace("id>>"+id);
        	if (application.gfn_IsNull(this.dsInfo_POP)) 
        	{
        		return;
        	}

        	return this.dsInfo_POP.lookup("id", id, "parent");
        }

        /**
         * @desc   : 팝업의 타입을 구함
         * @param  : id : 팝업 ID
         * @return : 팝업의 타입
         */
        this.getPopType = function (id)
        {
        	if (application.gfn_IsNull(this.dsInfo_POP)) 
        	{
        		return;
        	}

        	return this.dsInfo_POP.lookup("id", id, "type");
        }

        /**
         * @desc   : 팝업 정보 삭제
         * @param  : id : 팝업 ID
         * @return : 없음
         */
        this.delInfo = function (id)
        {
        	if (!application.gfn_IsNull(this.dsInfo_POP)) 
        	{
        		var row = this.dsInfo_POP.findRow("id", id);
        		this.dsInfo_POP.deleteRow(row);
        	}
        }

        this.gfn_POP_delInfoAll = function ()
        {
        	this.dsInfo_POP.clearData();
        }

        this.gfn_Msg = function (id,title,desc,type,bCallback,callObj)
        {
        	var callback = "msg_callback";	
        	
        	if (application.gfn_IsNull(id)) 
        	{
        		id = "MSG";
        	}

        	if (application.gfn_IsNull(type)) 
        	{
        		type = "OK";
        	}

        	if (application.gfn_IsNull(bCallback) || bCallback == false) 
        	{
        		callback = "";
        	}

        	if (application.gfn_IsNull(callObj)) 
        	{
        		callObj = this;
        	}

        	var arg = new Array();
        	arg[0] = title;
        	arg[1] = desc;
        	arg[2] = type;
        	
        	//this.gfn_POP_create(id, "cmmn::frmMsg.xfdl", callback, callObj, arg, "", this.getOwnerFrame().form);
        	this.gfn_POP_create(id, "cmmn::CmmnMsgPop.xfdl", callback, callObj, arg, "POP", application.goMain.divBase);

        }

        this.gfn_IncludeTest = function ()
        {
        	trace("TEST!!");
        }

        var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm,qid,edtId,btnId,outDs,option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm, qid, edtId, btnId, outDs, option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj, e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm, qid, edtId, btnId, outDs, option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj, e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm, qid, edtId, btnId, outDs, option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj, e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm, qid, edtId, btnId, outDs, option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj, e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };var SCPopup = {
        	runTimeMode : "As-Is",
        	option : {isMainUpjang:""},
        	form : null,
        	TmSearch : "SCPopup.TmSearch", //팀검색
        	UserSearch : "SCPopup.UserSearch", //사용자검색
        	PersonalSearch : "SCPopup.PersonalSearch", //사원검색
        	ZipSearch : "SCPopup.ZipSearch", //우편번호검색
        	
        	/**
        	 * @class 주어진 조건에 의해 Combo에 Data를 Binding한다.
        	 * @param thisForm - 현재 Form Object
        	 * @param qid - 조회하고자 하는 대상의 고유 KEY
        	 * @param edtId - Edit Object ID (문자열)
        	 * @param btnId - 찾기Button Object ID (문자열)
        	 * @param outDs - 조회된 결과를 Binding할 Dataset Object로 null인 경우에는 내부적으로 생성한다.
        	 * @param option - qid를 조회할 시 필요한 조건(JSON 형태)
        	 * @param [옵션] event - 팝업을 호출하기 전.후에 대한 trigger Event명을 기술한다.(JSON형태)
        	 *                 before : Popup 호출 전에 대한 Event명
        	 *                 after  : Popup에서 Data를 선택한 이후에 대한 Event명
        	 * @return 
        	 */
        	bind : function(thisForm, qid, edtId, btnId, outDs, option) {
        		SCPopup.form = thisForm;
        		//Output Dataset이 없는경우에는 내부적으로 Dataset을 생성한다.
        		if (outDs == null || outDs == "") {
        			var outDsId = ""; // = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj, e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };
        			if (btnId.indexOf("GRID:") > -1)
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_");
        			}
        			else
        			{
        				outDsId = "ds_hwfsBindingPopup_"+edtId.split(".").join("_")+btnId.split(".").join("_");
        			}
        			
        			thisForm.removeChild(outDsId);
        			outDs = new Dataset();
        			outDs.id = outDsId;
        			outDs.name = outDsId;
        			thisForm.addChild(outDsId, outDs);
        		}
        		
        		//옵션에 대하여 선언되지 않는 경우에는 초기화 한다.
        		if (option == undefined || option == null || option == "") option = {};
        		
        		//event에 대하여 선언한다.
        		var event = {};
        		if (arguments.length > 6) {
        			event = arguments[6];
        			
        			if (event.before == undefined) event.before = "NVL";
        			if (event.after == undefined) event.after = "NVL";
        		}
        		else {
        			event = {before:"NVL", after:"NVL"};
        		}
        		
        		//Controller로 전송할 Parameter를 설정한다.
        		var parameter = {
        			qid : qid,
        			edtId : edtId,
        			btnId : btnId,
        			outDs : outDs.name,
        			option : option,
        			event : event
        		};
        		
        		//[[Grid의 팝업을 처리한다.
        		if (btnId.indexOf("GRID:") > -1)
        		{
        			var grid = eval(edtId.substring(0, edtId.lastIndexOf(".")));
        			var columnId = edtId.substr(edtId.lastIndexOf(".")+1);

        			for (var i=0, len=grid.getCellCount("body"); i<len; i++) {
        				if (grid.getCellProperty("body", i, "text") == "bind:"+columnId) {
        					grid.setCellProperty("body", i, "edittype", "expand");
        					grid.setCellProperty("body", i, "expandshow", "show");
        					grid.setCellProperty("body", i, "expandsize", "21");
        					//grid.setCellProperty("body", i, "combodataset", dataset.name);
        				}
        			}
        			
        			grid[columnId] = gfn_jsonObjectToString(parameter);
        			grid.autoenter = "select";
        			grid.onexpandup.setHandler(0, function(obj, e) {
        				SCPopup.doProcessGridPopupEvent(obj, e);
        			});
        		}
        		//Grid의 팝업을 처리한다.]]
        		//[[폼의 팝업을 처리한다.
        		else
        		{
        			//[[Button에 대하여 Event를 등록한다.
        			var btn = eval(btnId);
        			btn.userdata_form_name = thisForm.name;
        			btn.userdata_oid_name = edtId + "_" + btnId;
        			btn.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			btn.onclick.addHandler(function(obj, e) {
        				if (gfn_isNull(obj.userdata))
        				{
        					SCPopup.doProcessPopupEvent(obj);
        				}
        			});
        			//Button에 대하여 Event를 등록한다.]]
        			
        			//[[Edit에 대하여 Event를 등록한다.
        			var edt = eval(edtId);
        			edt.readonly = true;
        			edt.userdata_form_name = thisForm.name;
        			edt.userdata_oid_name = edtId + "_" + btnId;
        			edt.userdata_variable_name = gfn_jsonObjectToString(parameter); 
        			edt.onkeydown.addHandler(function(obj, e) {
        				if (gfn_isNull(obj)) return "";
        				if (gfn_isNull(e))   return "";

        				// Enter 키
        				if(e.keycode == 13) 
        				{		
        					if (gfn_isNull(obj.userdata))
        					{
        						SCPopup.doProcessPopupEvent(obj);
        					}
        				}
        				// Del 키
        				else if(e.keycode == 46) 
        				{		
        					obj.value    = "";
        					obj.userdata = "";
        				}
        			});
        			//Edit에 대하여 Event를 등록한다.]]
        		}
        		//폼의 팝업을 처리한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Grid의 Expand Up Event에서 호출한다.
        	 */
        	doProcessGridPopupEvent : function(obj,e) {
        		var columnId = gfn_replace(obj.getCellProperty("body", e.cell, "text"), "bind:", "");
        		var json = gfn_jsonStringToObject(obj[columnId]);
        		var userdata_oid_name = json.edtId;
        		var bindDataset = eval(obj.binddataset);

        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		var strId;
        		var strURL;
        		var objArgument;
        		var nWidth;
        		var nHeight;
        		var strStyle;
        		var nLeft;
        		var nTop;
        		var isModeless;
        		var bShowTitle;
        		var strAlign;
        		
        		//[[팀검색
        		if (json.qid == SCPopup.TmSearch) {
        			
        			strId       = "TmSearch";
        			strURL      = "cmn::TmSearchPop.xfdl";
        			objArgument = {
        				P_BU_CD : json.option.qoBuCd,
        				P_MU_CD : json.option.qoMuCd,
        				P_USE_YN: json.option.qoUseYn
        			};
        			nWidth      = 513;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";

        		}
        		//팀검색]]
        		//[[사용자검색
        		else if (json.qid == SCPopup.UserSearch) {
        			strId       = "UserSearch";
        			strURL      = "cmn::UserSearchPop.xfdl";
        			objArgument = {
        				P_SOSOK_CODE : json.option.qoSosokCode,
        				P_SOSOK_NAME : json.option.qoSosokName,
        				P_USER_GROUP : json.option.qoUserGroup,
        				P_USE_YN     : json.option.qoUseYn
        			};
        			nWidth      = 700;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사용자검색]]
        		//[[사원검색
        		else if (json.qid == SCPopup.PersonalSearch) {
        			strId       = "PersonalSearch";
        			strURL      = "cmn::PersonalSearchPop.xfdl";
        			objArgument = {
        				P_MU_CD : json.option.qoMuCd,
        				P_TM_CD : json.option.qoTmCd,
        				P_TM_NM : json.option.qoTmNm
        			};
        			nWidth      = 566;
        			nHeight     = 495;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//사원검색]]
        		//[[우편번호검색
        		else if (json.qid == SCPopup.ZipSearch) {
        			strId       = "ZipSearchPop";
        			strURL      = "cmn::ZipSearchPop.xfdl";
        			objArgument = null;
        			nWidth      = 614;
        			nHeight     = 525;
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}
        		//우편번호검색]]
        		else {
        			//[[팝업의 기본디자인을 설정한다.
        			var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_");
        			setVariable(newVariableName, "");
        			
        			var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        			var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        			var strInDs     = "";
        			var strOutDs    = "";
        			var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        			var strCallback = "";
        			var bAsync      = false;
        			gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        			var retVariableValue = eval(newVariableName);
        			var retJson = gfn_jsonStringToObject(retVariableValue);
        			//팝업의 기본디자인을 설정한다.]]

        			strId       = userdata_oid_name;
        			strURL      = "cmn::CommonPopup.xfdl";
        			objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        			nWidth      = parseInt(retJson.width);
        			nHeight     = parseInt(retJson.height);
        			strStyle    = "";
        			nLeft       = -1;
        			nTop        = -1;
        			isModeless  = false;
        			bShowTitle  = true;
        			strAlign    = "-1";
        		}

        		//[[팝업창을 호출한다.
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var bindingCodeColumn;
        			var bindingNameColumn;
        			
        			//[[팀검색
        			if (json.qid == SCPopup.TmSearch) {
        				bindingCodeColumn = "tmCd";
        				bindingNameColumn = "tmNm";
        			}
        			//팀검색]]
        			//[[사용자검색
        			else if (json.qid == SCPopup.UserSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사용자검색]]
        			//[[사원선택
        			else if (json.qid == SCPopup.PersonalSearch) {
        				bindingCodeColumn = "sabun";
        				bindingNameColumn = "nmKor";
        			}
        			//사원선택]]
        			//[[우편번호검색
        			else if (json.qid == SCPopup.ZipSearch) {
        				bindingCodeColumn = "zip";
        				bindingNameColumn = "addr";
        			}
        			//우편번호검색]]
        			else {
        				bindingCodeColumn = retJson.bindingCode;
        				bindingNameColumn = retJson.bindingName;
        			}

        			bindDataset.setColumn(bindDataset.rowposition, columnId, arrRtn[bindingNameColumn]);
        			bindDataset.setColumn(bindDataset.rowposition, gfn_replace(json.btnId, "GRID:", ""), arrRtn[bindingCodeColumn]);

        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	},
        	
        	/**
        	 * @class 내부 Event Function으로 Button click Event와 Edit KeyDown Event에서 호출한다.
        	 */
        	doProcessPopupEvent : function(obj) {
        		var json = gfn_jsonStringToObject(obj.userdata_variable_name);
        		
        		if (json.event.before != "NVL") {
        			var before = eval(json.event.before);
        			var beforeParameter = {
        				oid : obj.userdata_oid_name,
        				option : json.option
        			};
        			
        			if (!before(beforeParameter)) return;
        		}

        		json.option.value = "";
        		
        		//[[팝업의 기본디자인을 설정한다.
        		var newVariableName = "gs_hwfsBindingPopup_"+json.edtId.split(".").join("_")+json.btnId.split(".").join("_");
        		setVariable(newVariableName, "");
        		
        		var strSvcID    = "hwfsBindingPopup,"+newVariableName;
        		var strURL      = "/sc/cmn/binding/popupDesign.xdo";
        		var strInDs     = "";
        		var strOutDs    = "";
        		var strArg      = "qid="+json.qid+" variableName="+newVariableName;
        		var strCallback = "";
        		var bAsync      = false;
        		gfn_transaction(SCPopup.form, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);

        		var retVariableValue = eval(newVariableName);
        		var retJson = gfn_jsonStringToObject(retVariableValue);
        		//팝업의 기본디자인을 설정한다.]]

        		//[[팝업창을 호출한다.
        		var strId       = obj.userdata_oid_name;
        		var strURL      = "cmn::CommonPopup.xfdl";
        		var objArgument = {SEND_DESIGN_PARAMETER:retVariableValue, SEND_PARAMETER:gfn_jsonObjectToString(json)};
        		var nWidth      = parseInt(retJson.width);
        		var nHeight     = parseInt(retJson.height);
        		var strStyle    = "";
        		var nLeft       = -1;
        		var nTop        = -1;
        		var isModeless  = false;
        		var bShowTitle  = true;
        		var strAlign    = "-1";

        		// 리턴값을 배열로 받을 경우	
        		var arrRtn = gfn_dialog(strId, strURL, objArgument, nWidth, nHeight, strStyle, nLeft, nTop, isModeless, bShowTitle, strAlign);
        		
        		if (arrRtn instanceof Object)
        		{
        			var edit = eval(json.edtId);
        			edit.value = arrRtn[retJson.bindingName];
        			edit.userdata = arrRtn[retJson.bindingCode];
        			
        			if (json.event.after != "NVL") {
        				var after = eval(json.event.after);
        				var afterParameter = {
        					oid : obj.userdata_oid_name,
        					option : json.option,
        					datasetName : json.outDs
        				};
        				
        				after(afterParameter, arrRtn);
        			}
        		}
        		//팝업창을 호출한다.]]
        	}
        };
        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();
