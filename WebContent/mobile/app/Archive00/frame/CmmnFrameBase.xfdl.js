(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        this.on_create = function()
        {
            // Declare Reference
            var obj = null;
            
            if (Form == this.constructor) {
                this.set_name("CmmnFrameBase");
                this.set_titletext("Base Frame");
                this.set_scrollbars("autovert");
                this._setFormPosition(0,0,540,942);
            }
            this.style.set_background("black");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"cnt\" size=\"20\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"msgId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/><Column id=\"dvicId\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"body\" type=\"STRING\" size=\"256\"/><Column id=\"msg\" type=\"STRING\" size=\"256\"/><Column id=\"createTime\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Div("divBase", "absolute", "0", "0", "540", "923", null, null, this);
            obj.set_taborder("0");
            obj.set_scrollbars("none");
            obj.style.set_background("#ffffffff");
            obj.set_async("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "ScreenPhone", 540, 942, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameBase");
            		p.set_titletext("Base Frame");
            		p.style.set_background("black");
            		p.set_scrollbars("autovert");

            		p.divBase.set_taborder("0");
            		p.divBase.set_scrollbars("none");
            		p.divBase.style.set_background("#ffffffff");
            		p.divBase.set_async("false");
            		p.divBase.move("0", "0", "540", "923", null, null);

            	}
            );
            this.addLayout(obj.name, obj);

            //-- Normal Layout
            obj = new Layout("layoutPad", "ScreenPad", 708, 942, this,
            	//-- Layout function
            	function(p) {
            		p.style.set_background("#000000");

            		p.divBase.set_scrollbars("autovert");
            		p.divBase.move("84", "0", "540", "923", null, null);
            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_list");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameBase.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameBase.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 메인프레임
        // [프로그램]		CmmnFrameBase.xfdl
        // [설명]
        // 		프로젝트 실행 시 최초로 띄워지는 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2014.07.01
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.fo_hisPOP = new Array(); //팝업 히스토리
        this.loginFlag = "N";
        this.loginPopFlag = "N";
        this.gubun = undefined;
        this.str = undefined;

        // 모바일런타임deviceAPI용
        this.fspmob;

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /** 
         * Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */
        this.CmmnFrameBase_onload = function(obj,e)
        {

        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);
        	
        	this.f_sFlagMob = "";
        	
        	//뒤로가기 정의
        	application.gv_backFlag = "menu";

        	//TODO 변경 필요
        	application.goMain = this;

        	this.fn_getAppInfo();
        	
         	if(application.gv_runMode == "L" || application.gv_runMode == "Runtime" || application.gv_runMode == "Hybrid")
          	{
         		this.divBase.set_url("frame::CmmnFrameMain.xfdl");
          	}
          }

        /** 
         * Form이 Load될 때, 초기화 작업을 정의
         * @param : 없음
         * @return : 없음
         */
        this.fn_init = function()
        {
        	//로컬 저장 값 전부가져오기 
        	var valKeys = "ID,PW,SAVEAUTO,SAVEID,PUSHAPP";
        	
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.getValueAll();
        }

        /** 
         *Timer가 설정된 경우 설정된 시간 간격으로 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */
        this.CmmnFrameBase_ontimer = function(obj,e)
        {
        	// 팝업을 띄우면서 동적으로 생성한 object를 파기하기 위한 타이머
        	// lib/lib_POP의 gfn_POP_close함수에서 Timer 호출
        	if (e.timerid == application.gvTimerID_PopDestroy) 
        	{
        		this.killTimer(application.gvTimerID_PopDestroy);
        		for (var i = 0; i < application.goPopDestroy.length; i++) 
        		{
        			if (!application.gfn_IsNull(application.goPopDestroy[i])) 
        			{
        				//trace(application.goPopDestroy[i].name + " destroy : " + application.goPopDestroy[i].destroy());
        			}
        		}
        		application.goPopDestroy = null;
        	}
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /** 
         *action 처리 함수. 주로 화면 이동 시 사용
         * @param
        	id : action id
         * @return : 없음
         */
        this.fn_action = function(id)
        {
        	//trace("this.fo_hisPOP.length BASE >>" +this.fo_hisPOP.length);
        	switch (id)
        	{
        		case "MAIN":		// 메인
        			this.divBase.set_url("frame::CmmnFrameMain.xfdl");
        			break;
        			
        		case "PASS":		// Passing (Only Test)
        			this.divBase.set_url("frame::CmmnFrameMain.xfdl");
        			break;
        			
        		default:
        			if (this.divBase.url == "frame::CmmnFrameMain.xfdl")
        			{	
        				this.divBase.fn_actionMain(id);
        			}
        			break;
        	}
        }

        /** 
         * 화면title 문구 설정.
         * @param
        	strTitle : 문구
         * @return : 없음
         */
        this.fn_setTitle = function (strTitle)
        {
        	application.goTopSub.fn_setTitle(strTitle);
        }

        /*================================================================================
         * 6. FSPmobile 관련 Script
         *===============================================================================*/
        this.fs_serverUrl = undefined;
        this.fs_deviceID = undefined;
        this.fs_devDevice = undefined; //개발 장비
        this.fs_appVersion =  undefined;

        /**
         *	앱에 대한 정보를 가져온다.
         **/
        this.fn_getAppInfo = function ()
        {
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.getAppInfo();
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_success = function(obj,e)
        {
        	if (e.reason == 0)	// getAppInfo
        	{
        		try{
        			var info = e.returnvalue;
        		
        			this.fs_serverUrl = info.serverUrl;
        			this.fs_deviceID = info.deviceID;
        			this.fs_devDevice = info.devDeviceYN;
        			this.fs_appVersion =  info.appVersion;
        			this.fn_init();
        		}
        		catch (e) {
        			trace("실패" + e);
        		}
        	}
        	else if (e.reason == 23) // getValueAll
        	{
        		var rtnObj = e.returnvalue.result;
        		
        		//글로벌 변수 셋팅 ID, PW, SAVEID, PUSHAPP 

        		//자동 로그인
        		if(rtnObj.SAVEAUTO == "true" || rtnObj.SAVEAUTO == true)
        		{
        			application.gv_autoLogin = rtnObj.SAVEAUTO;
        			
        			if (!application.gfn_IsNull(rtnObj.ID))
        			{
        				application.gv_ID = rtnObj.ID;
        			}
        			if (!application.gfn_IsNull(rtnObj.PW))
        			{
        				application.gv_PW = rtnObj.PW;
        			}
        			
        		}
        		
        		if(rtnObj.SAVEID == "true" || rtnObj.SAVEID == true)
        		{
        			application.gv_saveId= rtnObj.SAVEID;
        			
        			if (!application.gfn_IsNull(rtnObj.ID))
        			{
        				application.gv_ID = rtnObj.ID;
        			}
        			
        		}
        		
        		if(rtnObj.PUSHAPP == "true" || rtnObj.PUSHAPP == true)
        		{
        			application.gv_pushChk= rtnObj.PUSHAPP;
        		}else{
        			application.gv_pushChk= false;
        		}				
        		
        		if ( ((rtnObj.SAVEAUTO == "false" || rtnObj.SAVEAUTO == false) && (rtnObj.SAVEID == "false" || rtnObj.SAVEID == false)))
        		{
        			application.gv_ID = "";
        			application.gv_PW = "";
        			application.gv_autoLogin = false;
        			application.gv_saveId = false;			
        		}
        		
        		
        		//
        		try {
        			if ( this.divBase.url == "frame::CmmnFrameMain.xfdl" ) {
        				if ( !gfn_isNull(this.divBase.components["divPOP_Login"]) && application.gvLoginYN != "Y" ) {
        					this.divBase.divPOP_Login.fn_init();
        				}
        			}
        		} catch (e) {
        			
        		}
        		
        		this.divBase.set_url("frame::CmmnFrameMain.xfdl");
        		
        	}
        	else if (e.reason == 25)	// setValues
        	{
        		//20141029화면이 떠있을때 push 받기
        		//this.fspmob_push(this, "fn_callbackPush");
        	}
        	else if (e.reason == 17)	// badgeCount
        	{
        		if(this.gfn_isNull(this.str))
        		{
        			application.goButtom.fn_search();
        		}
        	}	
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_error = function(obj,e)
        {
        	if (e.reason == 2)
        	{
        		this.trace(e.errormsg);
        	}
        	else if (e.reason == 17)	// setValues
        	{
        		this.trace(e.errormsg);
        	}
        }

        /** 
         * 뒤로가기.
         * @param  : 없음
         * @return : 없음
         */
        this.fn_back = function ()
        {
        	application.gv_isHybrid = "Y";
        	
        	//팝업창이 오픈된 상태이고 로그인 창에서 기타 팝업이 오픈된 상태일 경우 백버튼 막음
        	if(this.fo_hisPOP.length > 1 && this.loginPopFlag == "Y")
        	{
        		return false;
        	}
        	
        	//팝업창이 오픈된 상태이고 로그인 프래그 값이 N인경우 디바이스 백버튼을 막음
        	if(this.fo_hisPOP.length > 0 && this.loginFlag == "N")
        	{
        		return false;
        	}
        	
        	//뒤로가기 체크를 위한 웨이커서 (전송중체크)
        	if(application.gvWaitCount > 0)
        	{
        		 return false;
        	}
        	
        	if (!application.gfn_IsNull(this.divBase["divPOP_Login"]) ||
        	    this.divBase.divMain.url == "frame::CmmnFrameMenu.xfdl" && (!this.divBase.divSub.visible)
        	   ) 
        	{
        		this.gfn_Msg("exit", "종료", "종료 하시겠습니까?", "YN", true, this);
        	}	
        	else 
        	{
        		this.divBase.fn_back();
        	}			
        }

        /** Message callback 함수
         * @param
        	id : id
        	rtn : type이 "OK" 일 때는 none
        	type이 "YN" 일 때는 "Y" or "N"
         * @return : 없음
         * @note : Alert 이나 Confirm 메시지의 콜백 함수
         *         gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다.
         */
        this.msg_callback = function (id,rtn)
        { 
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        	if (id == "exit") 
        	{
        		if (rtn == "Y") 
        		{
        			if (application.gvLoginYN == "Y")
        				application.goMain.fn_action("EXIT");
        			else
        				application.exit();
        		}
        		else
        		{
        			return;
        		}
        	}
        	
        	if (id == "confirmBack") 
        	{
        		if (rtn == "Y") 
        		{
        			if (this.divBase.divMain.url == "frame::CmmnFrameMenu.xfdl" && (!this.divBase.divSub.visible)) 
        			{
        				this.gfn_Msg("exit", "종료", "종료 하시겠습니까?", "YN", true, this);
        			}	
        			else 
        			{
        				this.divBase.fn_back();
        			}
        		}
        		else
        		{
        			
        		}
        	}
        }

        /*******************************************************************************
        * 기      능   :  설정정보 저장
        * 설      명   :  저장
        ********************************************************************************/
        this.f_sFlagMob; //알림(Push) Flag 로그인 화면에서 설정

        
        //로컬저장
        this.fn_localSave = function()
        {
        	var sAuto = application.gv_autoLogin;
        	var saveId = application.gv_saveId;
        	var sId   = application.gv_ID;
        	var sPw   = application.gv_PW;
        	var chkApp = "true";
        	
        	var vals = {
        	TMP1 : "TMP1"
        		,SAVEAUTO  : sAuto
        		, SAVEID  : saveId
        		, PUSHAPP : chkApp
        		, ID      : sId
        		, PW      : sPw
        		, TMP2 : "TMP2"
        	};	
        	
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.setValues(vals);
        }

        //push 알림 받았을 시 콜백
        this.fn_callbackPush = function(code,msg)
        {
        	if(code == 0)
        	{
        		this.fn_getCnt();
        		
        	}
        }

        /** 
         * 토스트호출 시 콜백함수.
         * @param
        	TODO : 
         * @return : 없음
         */
        this.fnCallbackToast = function (a,b,c)
        {
        	this.fn_getCnt();
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : BadgeCount갱신을 위한 팀장승인이 필요한 총 건수 추출
         *---------------------------------------------------------------------------------------------*/
        this.fn_getCnt = function (chk)
        {
        	this.str = chk;
        	
        	var strSvcID         = "getCnt";
            var strUrl     		 = "ms/mtm/teamLeaderApp/selectCount.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_list=ds_list";
        	var strArguments	 = "tmCd=" + nexacro.wrapQuote(application.g_Tm_Cd);
        		strArguments     += " sabun=" + nexacro.wrapQuote(application.g_EmpNo);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = false;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		//팀장승인조회
                case "getCnt" :	
                	
        			var index = application.gds_menu.findRowExpr("menuName=='팀장승인'");
        			
        			if(index == -1)
        			{
        				var cnt = new Number(this.ds_list.getColumn(0, "0"));
        				// 모바일 런타임 전환 작업 20150725 김광호
        				this.fspmob.setBadgeCount(cnt);
        			}
        			else
        			{
        				var cnt = new Number(this.ds_list.getColumn(0, "cnt"));
        				// 모바일 런타임 전환 작업 20150725 김광호
        				this.fspmob.setBadgeCount(cnt);
        			}
        					
          			break;  		
            }     
            
        }

        
        // 모바일런타임전환 - 뒤로가기 버튼 동작 이벤트
        this.CmmnFrameBase_ondevicebuttonup = function(obj,e)
        {
        	
        // 	if(application.goMenu.name == "divPOP_board")
        // 	{
        // 		application.goMain.gfn_POP_close(application.goMenu, "CLOSEONLY");
        // 	}
        	
        	if ( e.button == 2 )	// Android단말 취소키 제어
        	{
        		if(!this.gfn_isNull(application.goMenu.ds_grd))
        		{
        			if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        			{	
        				application.goMain.gfn_Msg("confirmBack", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        			}
        			else
        			{
        				this.fn_back()
        			}	
        		}
        		else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        		{
        			if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        			{	
        				application.goMain.gfn_Msg("confirmBack", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        			}
        			else
        			{
        				this.fn_back()
        			}	
        		}
        		else
        		{
        			this.fn_back()
        		}	
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameBase_onload, this);
            this.addEventHandler("ontimer", this.CmmnFrameBase_ontimer, this);
            this.addEventHandler("ondevicebuttonup", this.CmmnFrameBase_ondevicebuttonup, this);

        };

        this.loadIncludeScript("CmmnFrameBase.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
