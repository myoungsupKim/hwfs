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
                this.set_name("CmmnFrameSetting");
                this.set_titletext("설정");
                this.set_scrollbars("autovert");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_settingList", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"autoLoginYn\" size=\"1\" type=\"STRING\"/><Column id=\"saveIdYn\" size=\"1\" type=\"STRING\"/><Column id=\"pushYn\" size=\"1\" type=\"STRING\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staTitleT03", "absolute", "10", "469", "520", "173", null, null, this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitleT00", "absolute", "10", "5", "520", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitleT01", "absolute", "10", "385", "520", "70", null, null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitleT04", "absolute", "10", "640", "520", "70", null, null, this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("28");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Button("btn_appExit", "absolute", "7", "7", "117", "47", null, null, this);
            obj.set_taborder("29");
            obj.set_text("앱 종료");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_test", "absolute", "239", "7", "169", "47", null, null, this);
            obj.set_taborder("30");
            obj.set_text("로컬저장확인");
            obj.set_cssclass("btn_WF_Function");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_setting", "absolute", "412", "7", "117", "47", null, null, this);
            obj.set_taborder("31");
            obj.set_text("설정저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("32");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "-2", "58", "226", "59", null, null, this);
            obj.set_taborder("33");
            obj.set_text("자동로그인");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_autoLogin", "absolute", "460", "54", "70", "70", null, null, this);
            obj.set_taborder("34");
            obj.set_value("N");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            obj.style.set_padding("20 20 20 20");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "176", null, "59", "0", null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "-2", "176", "226", "59", null, null, this);
            obj.set_taborder("36");
            obj.set_text("알림(Push)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_app", "absolute", "460", "170", "70", "70", null, null, this);
            obj.set_taborder("37");
            obj.set_value("N");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            obj.style.set_padding("20 20 20 20");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "234", null, "59", "0", null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "-2", "234", "226", "59", null, null, this);
            obj.set_taborder("39");
            obj.set_text("버전 정보");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_version", "absolute", "280", "234", "226", "59", null, null, this);
            obj.set_taborder("40");
            obj.set_text("1.0.1");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("45");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "-2", "116", "226", "59", null, null, this);
            obj.set_taborder("46");
            obj.set_text("아이디저장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_saveId", "absolute", "460", "112", "70", "70", null, null, this);
            obj.set_taborder("47");
            obj.set_value("N");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            obj.style.set_padding("20 20 20 20");
            this.addChild(obj.name, obj);

            obj = new Edit("Name", "absolute", "8", "554", "507", "26", null, null, this);
            obj.set_taborder("48");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("svrAppVersion", "absolute", "8", "579", "507", "26", null, null, this);
            obj.set_taborder("49");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("appName", "absolute", "8", "604", "507", "26", null, null, this);
            obj.set_taborder("50");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("projectName", "absolute", "8", "629", "507", "26", null, null, this);
            obj.set_taborder("51");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("serverUrl", "absolute", "8", "654", "507", "26", null, null, this);
            obj.set_taborder("52");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("serverID", "absolute", "8", "679", "507", "26", null, null, this);
            obj.set_taborder("53");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("deviceID", "absolute", "8", "704", "507", "26", null, null, this);
            obj.set_taborder("54");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("appID", "absolute", "8", "728", "507", "26", null, null, this);
            obj.set_taborder("55");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("CmmnFrameMyKU");
            		p.set_titletext("설정");
            		p.set_scrollbars("autovert");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_settingList");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameSetting.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameSetting.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통
        // [부시스템명]	setting 설정화면
        // [프로그램]		CmmnFrameSetting.xfdl
        // [설명]
        // 		setting 설정화면
        // [작성자명] 		투비소프트
        // [작성일자]		2014.09.24
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.02.05 : 강대성 : 신규생성.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
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
        this.CmmnFrameSetting_onload = function(obj,e)
        {
        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);
        	
        	this.fn_init();	
        }

        /** 
         * 화면셋팅
         * @param  : 없음
         * @return : 없음
         */
        this.fn_init = function ()
        { 
        	this.fn_search();	
        	this.chk_autoLogin.set_value(application.gv_autoLogin);
        	this.chk_saveId.set_value(application.gv_saveId);
        	
        	this.sta_version.set_text(application.goMain.fs_appVersion);
        	//this.fn_getAppInfo();	
        }

        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/
        /** 
         * 설정저장버튼클릭 
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btn_setting_onclick = function(obj,e)
        {
        	if(this.chk_app.value == "N")
        	{
        		application.goMain.gfn_Msg("settingN", "설정저장", "알림(PUSH) 거부시 알림 메시지를 받을 수 없습니다. 저장 하시겠습니까?", "YN", true, this);
        	
        	}
        	else
        	{
        		application.goMain.gfn_Msg("setting", "설정저장", "저장 하시겠습니까?", "YN", true, this);
        	}
        }

        
        /** 
         * 앱종료버튼클릭 
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btn_appExit_onclick = function(obj,e)
        {
        	application.goMain.gfn_Msg("exit", "종료", "종료 하시겠습니까?", "YN", true, this);	              
        }

        
        /*******************************************************************************
        * 기      능   :  설정정보 조회
        * 설      명   :  조회
        ********************************************************************************/
        this.fn_search = function()
        {
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mmb/loginSessionUpdate/selectList.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_settingList=ds_list";
        	var strArguments	 = "userId=" + nexacro.wrapQuote(application.g_userId);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*******************************************************************************
        * 기      능   :  설정정보 저장
        * 설      명   :  저장
        ********************************************************************************/
        this.fn_save = function ()
        {
        	this.ds_settingList.clearData();
        	this.ds_settingList.addRow();
        	
        	// 자동로그인	
        	if(this.chk_autoLogin.value == "true" || this.chk_autoLogin.value == true || this.chk_autoLogin.value == "Y")
        	{
        		this.ds_settingList.setColumn(0, "autoLoginYn", "Y");
        	}else{
        		this.ds_settingList.setColumn(0, "autoLoginYn", "N");
        	}
        	
        	// 아이디 저장	
        	if(this.chk_saveId.value == "true" || this.chk_saveId.value == true || this.chk_saveId.value == "Y")
        	{
        		this.ds_settingList.setColumn(0, "saveIdYn", "Y");
        	}else{
        		this.ds_settingList.setColumn(0, "saveIdYn", "N");
        	}
        	
        	// PUSH알림 설정
        	if(this.chk_app.value == "true" || this.chk_app.value == true || this.chk_app.value == "Y")
        	{
        		this.ds_settingList.setColumn(0, "pushYn", "Y");
        	}else{
        		this.ds_settingList.setColumn(0, "pushYn", "N");
        	}
        	
        	this.ds_settingList.setColumn(0, "userId", application.g_userId);
        	
        	
        	var strSvcID   		 = "save";
            var strUrl     		 = "ms/mmb/loginSessionUpdate/saveSettingList.xdo";
            var strInDataset     = "ds_list=ds_settingList:U";
            var strOutDataset    = "ds_settingList=ds_list";
            var strArguments	 = "";
            var strCallbackFunc	 = "fn_callBack";
            var bAsync			 = true;
            
            this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        }

        
        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
         
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
        					
        	}
        	if (id == "exit") 
        	{
        		if (rtn == "Y") 
        		{
        			//CmmnFrameBase 참조
        			application.goMain.fn_action("EXIT");
        		}
        		else
        		{
        			return;
        		}
        	}
        	if (id == "setting") 
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save();
        		}
        		else
        		{
        		}
        	}
        	if (id == "settingN") 
        	{
        		if (rtn == "Y") 
        		{
        			this.chk_app.set_value("N");
        			this.fn_save();
        		}
        		else
        		{
        		
        		}
        	}
        	if (id == "SUCCESS") // 저장성공
        	{	
        		//application.goMain.gfn_POP_close(this);
        	}
        }

        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {	
        	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		//환경설정 조회
                case "search" :
        			
        			// 조회 건수 확인  
                    if (this.ds_settingList.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else	// 조회건수가 1페이지 이상일때
                    {
        				this.chk_autoLogin.set_value(this.ds_settingList.getColumn(0,"autoLoginYn"));  //자동로그인여부
        				this.chk_saveId.set_value(this.ds_settingList.getColumn(0,"saveIdYn"));	       //아이디저장여부
        				this.chk_app.set_value(this.ds_settingList.getColumn(0,"pushYn"));	           //push 알림 수신여부
        				
        // 				if(this.ds_settingList.getColumn(0,"pushYn") == "Y")
        // 				{
        // 					this.Static08.set_visible(true);
        // 					this.Static09.set_visible(true);
        // 					this.sta_push03.set_visible(true);
        // 					this.Static06.set_top(393);
        // 					this.Static07.set_top(393);
        // 					this.sta_version.set_top(393);
        // 				
        // 				}else
        // 				{
        // 					this.Static08.set_visible(false);
        // 					this.Static09.set_visible(false);
        // 					this.sta_push03.set_visible(false);
        // 					this.Static06.set_top(234);
        // 					this.Static07.set_top(234);
        // 					this.sta_version.set_top(234);
        // 				}
        				
        			}
          			break;
          		//저장시
          		case "save" :
        			
        			application.goMain.gfn_Msg("SUCCESS", "메시지", "정상적으로 처리 되었습니다.", "OK", true, this);
        			
        			// 자동로그인 체크 시 아이디 저장
        			if ( this.chk_autoLogin.isChecked() ) {
        				application.gv_autoLogin = this.chk_autoLogin.isChecked();
        			}else{
        				application.gv_autoLogin = false;				
        			}
        			
        			// 아이디 저장 체크 시 아이디 저장
        			if ( this.chk_saveId.isChecked() ) {
        				application.gv_saveId = this.chk_saveId.isChecked();
        			}else{
        				application.gv_saveId = false;				
        			}
        			
        			// PUSH수신 여부체크 시
        			if ( this.chk_app.isChecked() ) {
        				var chkApp = this.chk_app.isChecked();
        			}else{
        				var chkApp = false;				
        			}	
        			
        			var sId   = application.gv_ID;
        			var sPw   = application.gv_PW;	
        	
        			var vals = {
        				SAVEAUTO  : application.gv_autoLogin
        				, SAVEID  : application.gv_saveId
        				, PUSHAPP : chkApp
        				, ID      : sId
        				, PW      : sPw		
        			};
        			
        			//로컬 저장
        			//this.fspmob_execute(this, "sharedData", "setValues", [vals], "callbackSetValues");	
        			this.fspmob.setValues(vals);
        	
        			break;
          		
            }   
            
        }

        
        // /****************************************************
        //  * 콜백 : 앱 설정에 대한 정보를 가져온다.
        //  *****************************************************/
        // this.fn_callbackGetAppInfo = function (errorCode, info)
        // {
        // 	try{
        // 		if (errorCode == 0) 
        // 		{
        // 			this.fs_appVersion =  info.appVersion;
        // 			this.sta_version.set_text(this.fs_appVersion);
        // 			
        // 			this.Name.set_value(info.Name);
        // 			this.svrAppVersion.set_value(info.svrAppVersion);
        // 			this.appName.set_value(info.appName);
        // 			this.projectName.set_value(info.projectName);
        // 			this.serverUrl.set_value(info.serverUrl);
        // 			this.serverID.set_value(info.serverID);
        // 			this.deviceID.set_value(info.deviceID);
        // 			this.appID.set_value(info.appID);
        // 			
        // 		}
        // 		else 
        // 		{
        // 			trace("앱 초기화에 실패했습니다. 다시 시작해 주십시오.");
        // 		}
        // 	}
        // 	catch (e) {
        // 		trace("실패" + e);
        // 	}
        // }

        /*================================================================================
         * 6. FSP 함수 관련 Script
         *===============================================================================*/
         

        this.btn_test_onclick = function(obj,e)
        {
        	//로컬저장 테스트
         	var valKeys = "PUSHAPP,PUSHMOB,SAVEAUTO,SAVEID,ID,PW";
        	this.fspmob.getValues(valKeys);
        }

        
        // /**
        //  *	앱에 대한 정보를 가져온다.
        //  **/
        // this.fs_appVersion =  undefined;
        // this.fn_getAppInfo = function ()
        // {
        // // 	var callbackName = "fn_callbackGetAppInfo";
        // // 	this.fspmob_getAppInfo(this, callbackName);
        // }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_success = function(obj,e)
        {
        // 	this.alert("e.reason : " + e.reason + "\n" +
        // 	           "e.returnvalue : " + JSON.stringify(e.returnvalue));
        	if (e.reason == 22) // getValues
        	{
        		var pushapp  = e.returnvalue.result.PUSHAPP;
        		var pushmob  = e.returnvalue.result.PUSHMOB;
        		var saveauto = e.returnvalue.result.SAVEAUTO;
        		var saveid   = e.returnvalue.result.SAVEID;
        		var id       = e.returnvalue.result.ID;
        		var pw       = e.returnvalue.result.PW;
        		this.alert("PUSHAPP : " + PUSHAPP + "\n" +
        		           "PUSHMOB : " + PUSHMOB + "\n" +
        		           "SAVEAUTO : " + SAVEAUTO + "\n" +
        		           "SAVEID : " + SAVEID + "\n" +
        		           "ID : " + ID + "\n" +
        		           "PW : " + PW);
        	}
        	else if (e.reason == "25")	// setValues
        	{
        	}
        }

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameSetting_onload, this);
            this.staTitleT03.addEventHandler("onclick", this.Static03_onclick, this);
            this.staTitleT00.addEventHandler("onclick", this.Static03_onclick, this);
            this.staTitleT01.addEventHandler("onclick", this.Static03_onclick, this);
            this.staTitleT04.addEventHandler("onclick", this.Static03_onclick, this);
            this.btn_appExit.addEventHandler("onclick", this.btn_appExit_onclick, this);
            this.btn_test.addEventHandler("onclick", this.btn_test_onclick, this);
            this.btn_setting.addEventHandler("onclick", this.btn_setting_onclick, this);
            this.chk_app.addEventHandler("onclick", this.chk_app_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameSetting.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
