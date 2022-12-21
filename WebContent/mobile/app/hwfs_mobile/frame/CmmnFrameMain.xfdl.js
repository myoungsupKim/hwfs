﻿(function()
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
                this.set_name("CmmnFrameMain");
                this.set_titletext("Main Frame");
                this.set_visible("true");
                this._setFormPosition(0,0,540,923);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_cmnAuth", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"srcYn\" type=\"STRING\" size=\"256\" sumtext=\"조회\"/><Column id=\"insYn\" type=\"STRING\" size=\"256\" sumtext=\"추가\"/><Column id=\"delYn\" type=\"STRING\" size=\"256\" sumtext=\"삭제\"/><Column id=\"savYn\" type=\"STRING\" size=\"256\" sumtext=\"저장\"/><Column id=\"prtYn\" type=\"STRING\" size=\"256\" sumtext=\"출력\"/><Column id=\"exlYn\" type=\"STRING\" size=\"256\" sumtext=\"엑셀\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_appDivcList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"appId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/><Column id=\"dvicId\" type=\"STRING\" size=\"256\"/><Column id=\"regTp\" type=\"STRING\" size=\"256\"/><Column id=\"autoLoginYn\" type=\"STRING\" size=\"256\"/><Column id=\"saveIdYn\" type=\"STRING\" size=\"256\"/><Column id=\"pushYn\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_commonCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"set1\" type=\"STRING\" size=\"256\"/><Column id=\"set2\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Div("divBottom", "absolute", null, null, "540", "90", "0", "0", this);
            obj.set_taborder("1");
            obj.set_scrollbars("none");
            this.addChild(obj.name, obj);

            obj = new Div("divSub", "absolute", "0", "0", "540", "833", null, null, this);
            obj.set_taborder("2");
            obj.set_visible("true");
            obj.set_scrollbars("autovert");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Div("divMain", "absolute", "0", "0", null, "833", "0", null, this);
            obj.set_taborder("0");
            obj.set_scrollbars("autovert");
            obj.style.set_background("#ffffffff");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Div("divRMenu", "absolute", "210", "0", "330", "923", null, null, this);
            obj.set_taborder("3");
            obj.set_visible("false");
            obj.set_url("frame::CmmnFrameRightMenu.xfdl");
            this.addChild(obj.name, obj);

            obj = new Div("div_calendar", "absolute", "10", "126", "520", "670", null, null, this);
            obj.set_taborder("4");
            obj.set_visible("false");
            obj.set_async("true");
            obj.set_applystyletype("cascade,keep");
            obj.set_url("cmmn::CmmnCalendarPop.xfdl");
            this.addChild(obj.name, obj);

            obj = new Div("div_calendarMonth", "absolute", "62", "187", "417", "569", null, null, this);
            obj.set_taborder("5");
            obj.set_visible("false");
            obj.set_url("cmmn::CmmnCalMonthPop.xfdl");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 833, this.divMain,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("0");
            		p.set_scrollbars("autovert");
            		p.style.set_background("#ffffffff");
            		p.set_visible("true");

            	}
            );
            this.divMain.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "ScreenPhone", 540, 923, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameMain");
            		p.set_titletext("Main Frame");
            		p.set_visible("true");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("fdl", "frame::CmmnFrameRightMenu.xfdl");
            this._addPreloadList("fdl", "cmmn::CmmnCalendarPop.xfdl");
            this._addPreloadList("fdl", "cmmn::CmmnCalMonthPop.xfdl");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameMain.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameMain.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 메인
        // [프로그램]		CmmnFrameMain.xfdl
        // [설명]
        // 		프로젝트 실행 메인 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.gubun = undefined;
        var nRow;
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
        this.CmmnFrameMain_onload = function(obj,e)
        {
        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);

        	application.goMainSub = this;	
        	
        	this.divMain.set_top(0);
        	
        	this.fn_init();
        	
        }

        this.fn_init = function ()
        {
        	this.divSub.set_left(0);
        	this.divSub.set_top(0);
        	this.divSub.set_visible(false);	
        	
        	application.goMain.gfn_POP_create("Login", "frame::CmmnFrameLogin.xfdl", "fn_callBackPOP", this, "", "FULL", this);
        		
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 권한 조회
         *---------------------------------------------------------------------------------------------*/
        this.fn_getAuth = function ()
        {
        	var strSvcID    = "getAuth";
            //var strURL      = "sc/cmn/selectMenu.xdo";
            var strURL      = "ms/cmn/mobileCommon/selectMenuList.xdo";
            var strInDs     = "";
            //var strOutDs    = "gds_menu=gdsMenu";
            var strOutDs    = "gds_menu=ds_list gds_upjangList=ds_list1";
            var strArg      = "";
            var strCallback = "fn_callBack";
            var bAsync      = false;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 권한 조회(웨딩 예약 권한)
         *---------------------------------------------------------------------------------------------*/
        this.fn_menuAuth = function ()
        {
        	var strSvcID    = "getMenuAuth";
            var strURL      = "ms/cmn/mobileCommon/selectMenuAuthList.xdo";
            var strInDs     = "";
            var strOutDs    = "gds_menuAuth=ds_list";
            var strArg      = "empNo=" + nexacro.wrapQuote(application.g_EmpNo);
            var strCallback = "fn_callBack";
            var bAsync      = false;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : logout 서비스 처리
         *---------------------------------------------------------------------------------------------*/
        this.fn_logout = function ()
        {
        	var strSvcID    = "logout";
            var strURL      = "sc/cmn/logout.xdo";
            var strInDs     = "";
            var strOutDs    = "";
            var strArg      = "";
            var strCallback = "fn_callBack";
            var bAsync      = true;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        /*-----------------------------------------------------------------------
         * 설명    : 접근로깅 처리
         *-----------------------------------------------------------------------*/
        this.fn_getCmnAuth = function ()
        {
            var strSvcID     = "getCmnAuth";
            var strURL       = "sc/cmn/authority/selectPgmAuth.xdo";
            var strInDs      = "";
            var strOutDs     = "gds_cmnAuth=dsOutput";
            var strArg       = "";
            var strCallback  = "fn_callBack";
            var bAsync       = false;
        //    var bProgress    = false;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 권한설정된 메뉴만 불러오기
         *---------------------------------------------------------------------------------------------*/
        this.fn_getMenuAuthList = function ()
        {
            var strSvcID    = "getMenuAuthList";
            var strURL      = "ms/cmn/mobileCommon/selectMenuList.xdo";
            var strInDs     = "";
            var strOutDs    = "gds_menu=ds_list";
            var strArg      = "empNo=" + nexacro.wrapQuote(application.g_EmpNo);
                strArg     += " userGroup=" + nexacro.wrapQuote(application.g_UserGroup);
                strArg     += " ccCd=" + nexacro.wrapQuote(application.g_Cc_Cd);
            var strCallback = "fn_callBack";
            var bAsync      = true;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        /*******************************************************************************
        * 기      능   :  로그인 후 사용자 디바이스 정보 갱신
        * 설      명   :  로그인 후 사용자 디바이스 정보 갱신
        ********************************************************************************/
        this.fn_loginAppDvicUpdate = function ()
        {
        	var strSvcID   		 = "loginAppDvicUpdate";
            var strUrl     		 = "ms/mmb/loginSessionUpdate/saveList.xdo";
            var strInDataset     = "ds_list=ds_appDivcList:U";
            var strOutDataset    = "ds_appDivcList=ds_list";
            var strArguments	 = "";
            var strCallbackFunc	 = "fn_callBack";
            var bAsync			 = true;
            
            this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 복수업장
         *---------------------------------------------------------------------------------------------*/
        this.fn_dualUpjang = function ()
        {
        	var strSvcID    = "dualUpjang";
            var strURL      = "ms/cmn/mobileCommon/selectDualUpjangList.xdo";
            var strInDs     = "";
            var strOutDs    = "gds_upjangList=ds_list";
            var strArg      = "";
            var strCallback = "fn_callBack";
            var bAsync      = false;

            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        // 임시 
        this.fn_getAuthTemp = function ()
        {	
        	// 임시 콜백 호출
        	this.fn_callBack("getAuth", 0, "메뉴를 불러오는데 실패하였습니다.");
        }

        // 권한(메뉴) 조회 후 후처리(권한에 따른 메뉴 필터링)
        this.fn_setAuthProcess = function ()
        {	
        	//this.fn_getMenuAuthList();
        	//application.goMenu.fn_init();	
        	this.divRMenu.fn_init();	
        }

        /** 
         *action 처리 함수. 주로 화면 이동 시 사용
         * @param
        	id : action id
         * @return : 없음
         */
        this.fn_actionMain = function(id)
        {
        	switch (id)
        	{
        		case "INIT":				// Home
        			//안드로이드4.3TODO
        			application.gv_menuId = "HOME";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameMenu.xfdl");
        			this.divBottom.set_url("frame::CmmnFrameBottom.xfdl");
        			this.divSub.set_url("");
        			//this.divSub.set_url("frame::CmmnFrameMenu.xfdl");	// TODO : divWork를 못찾아서 에러나서 감춤
        			this.divMain.bringToFront();
        			this.divSub.set_visible(false);
        			break;
        		case "HOME":				// Home
        			// bottom메뉴 접힌상태일때 올려줌.
        			this.divBottom.set_visible(true);
        			this.divMain.set_height(833);
        			this.divBottom.bringToFront();
        			//안드로이드4.3TODO
        			application.gv_menuId = "HOME";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameMenu.xfdl");
        			this.divSub.set_url("");
        			//this.divSub.set_url("frame::CmmnFrameMenu.xfdl");	// TODO : divWork를 못찾아서 에러나서 감춤
        			this.divMain.bringToFront();
        			this.divSub.set_visible(false);
        			break;
        		case "LOGIN":		// LOGIN
        			//안드로이드4.3TODO
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameLogin.xfdl");
        			this.divSub.set_url("");
        			this.divSub.set_url("frame::CmmnFrameMenu.xfdl");
        			this.divSub.set_visible(false);
        			break;
        		case "INFO":				// INFO
        			//application.goMain.gfn_Msg("alertTemp", "Information", "준비중입니다.", "OK");
         			application.gv_backFlag = "MENU";
         			application.gv_menuId = id;
         			application.gv_menuName = "기타메뉴";
         			application.gv_formUrl = "cmmn::CmmnUseInformation.xfdl";
         			this.divMain.set_url("");
         			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
         			this.divMain.bringToFront();
        			break;
        		case "INFOMENU":
        			application.gv_backFlag = "INFO";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;		
        		case "SETTING":				// SETTING
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = id;
        			application.gv_menuName = "설정화면";
        			application.gv_formUrl = "frame::CmmnFrameSetting.xfdl";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		case "CART":				// 장바구니
        			//trace("IN fn_back :: "+application.gv_backFlag);
        			//trace("application.gv_menuId :: "+application.gv_menuId);
        			//trace("application.gv_menuBefId :: "+application.gv_menuBefId);
        			if(application.gv_menuId == "HOME")
        			{
        				application.gv_backFlag = "MENU";
        			}
        			else
        			{
        				application.gv_backFlag = "MENUBEF";			
        			}			
        			
        			trace("application.g_System_Mst >>>>> " +application.g_System_Mst);
        			if(application.g_System_Mst != "FICS" && (application.g_Mu_Cd == "2002" || application.g_Mu_Cd == "2003")) //FS사업부, 외식사업부
         			{
        				application.gv_progrmId = "ShoppingBasket";
        				application.gv_menuName = "장바구니";
        				nRow = application.gds_menu.findRowExpr("menuName=='장바구니'");
        				application.gv_menuId = application.gds_menu.getColumn(nRow, "menuId");
        				
        				if(!this.gfn_isNull(application.gv_menuId))
        				{
        					application.gv_formUrl = "M_MOM::ShoppingBasket.xfdl";
        					this.divMain.set_url("");
        					this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        					this.divMain.bringToFront();
        					this.fn_getCmnAuth();
        				}
        				else
        				{
        					application.goMain.gfn_Msg("ALERT_0", "메세지", "장바구니 권한이 없습니다.", "OK");	
        				}
        				
         			}
         			else if(application.g_Mu_Cd == "2004" || application.g_System_Mst == "FICS") //식재사업부
         			{
        				application.gv_progrmId = "ShoppingFicsBasket";
        				application.gv_menuName = "식재장바구니";
        				nRow = application.gds_menu.findRowExpr("menuName=='식재장바구니'");
        				application.gv_menuId = application.gds_menu.getColumn(nRow, "menuId");
        				
        				if(!this.gfn_isNull(application.gv_menuId))
        				{
        					application.gv_formUrl = "M_MOM::ShoppingFicsBasket.xfdl";
        					this.divMain.set_url("");
        					this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        					this.divMain.bringToFront();
        					this.fn_getCmnAuth();
        				}
        				else
        				{
        					application.goMain.gfn_Msg("ALERT_0", "메세지", "장바구니 권한이 없습니다.", "OK");	
        				}			
        				
         			}
         			else if(application.g_System_Mst == "ADMIN") //관리자
         			{
        				application.gv_progrmId = "ShoppingBasket";
        				application.gv_menuName = "장바구니";
        				nRow = application.gds_menu.findRowExpr("menuName=='장바구니'");
        				application.gv_menuId = application.gds_menu.getColumn(nRow, "menuId");
        				
        				if(!this.gfn_isNull(application.gv_menuId))
        				{
        					application.gv_formUrl = "M_MOM::ShoppingBasket.xfdl";
        					this.divMain.set_url("");
        					this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        					this.divMain.bringToFront();
        					this.fn_getCmnAuth();
        				}
        				else
        				{
        					application.goMain.gfn_Msg("ALERT_0", "메세지", "장바구니 권한이 없습니다.", "OK");	
        				}	
        				
         			}
         			else
         			{
        				application.goMain.gfn_Msg("ALERT_0", "메세지", "장바구니 권한이 없습니다.", "OK");	
         			}			
         			
        			break;
        		case "SUBMENU":
        			application.gv_backFlag = "MENU";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			// 공통버튼 권한 조회 및 접근로깅 처리
        			this.fn_getCmnAuth();
        			break;
        		case "LOGOUT":
        			this.gubun = "logout";
        			this.fn_logout();
        			break;
        		case "EXIT":
        			this.gubun = "exit";
        			this.fn_logout();
        			break;
        		case "AFTERLOGOUT":
        			//application.gv_ID = "";
        			application.gv_PW = "";
        			//application.gv_saveId = false;
        			application.gv_autoLogin = false;
        			application.gvLoginYN = "N";
        			//application.goMain.fn_localSave();
        			application.goMain.gfn_POP_create("Login", "frame::CmmnFrameLogin.xfdl", "fn_callBackPOP", this, "", "FULL", this);
        			//app종료
        			//this.fspmob_remove();
        			break;
        		case "RIGHTMENU":
        			// bottom메뉴 접힌상태일때 올려줌.
        			this.divBottom.set_visible(true);
        			this.divMain.set_height(833);
        			this.divBottom.bringToFront();
        			// TODO : 동적으로  gds에서 가져와 화면을 오픈한다.
        			application.goMain.gfn_POP_create("divRMenu", this.divRMenu, "fn_callBackPOP", this, "", "POPDivx", this);
        			
        			
        			if (this.divMain.url == "frame::CmmnFrameSub.xfdl")
        			{
        				if (this.divMain.divWork.url == "M_MES::SurroundWorkplaceView.xfdl")
        				{
        					this.divMain.divWork.Map00.set_width(0);
        				}
        			}
        			
        			break;
        		case "TEST":
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = id;
        			application.gv_menuName = "테스트업무화면";
        			application.gv_formUrl = "sample::map_test.xfdl";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		case "TEST2":
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = id;
        			application.gv_menuName = "테스트";
        			application.gv_formUrl = "M_MPM::PhotoImageReqt_TEST.xfdl";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		case "TEST3":
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = id;
        			application.gv_menuName = "테스트업무화면2";
        			application.gv_formUrl = "M_MES::SurroundWorkplaceViewTest.xfdl";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		case "TEST4":
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = id;
        			application.gv_menuName = "테스트업무화면";
        			application.gv_formUrl = "sample::frmWorkTest3.xfdl";
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		case "DeviceTest":
        			this.divMain.set_url("");
        			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        			this.divMain.bringToFront();
        			break;
        		default :
        			if(id.indexOf(".xfdl") > -1)
        			{
        				application.gv_formUrl = id;
        				this.divSub.set_url("");
        				this.divSub.set_url("frame::CmmnFrameSub.xfdl");
        				this.divSub.set_visible(true);
        				this.divSub.bringToFront();
        				return false;
        			}
        			this.divSub.set_url("");
        			this.divSub.set_url("frame::CmmnFrameSub.xfdl");
        			this.divSub.set_visible(true);
        			this.divSub.bringToFront();
        			break;
        	}
        }

        // 뒤로가기 동작 정의
        this.fn_back = function (){

        	if(application.gv_backFlag == "SETTING")
        	{
        		this.divMain.set_url("");
        		this.fn_actionMain("HOME");
        	}
        	else if(application.gv_backFlag == "MENU")
        	{
        		this.fn_actionMain("HOME");
        	}
        	else if(application.gv_backFlag == "INFO")
        	{
        		this.fn_actionMain("INFO");
        	}
        	else if(application.gv_backFlag == "HOME")
        	{
        		this.fn_actionMain("HOME");
        	}
        	else //일반메뉴명에 따라 다르다.
        	{
        		// action 실행
        		application.gv_menuId = application.gv_menuBefId;
        		application.gv_formUrl = application.gv_formBefUrl;
        		application.gv_menuName = application.gv_menuBefName;
        		application.gv_progrmId = application.gv_progrmBefId;
        		application.goMain.fn_action("SUBMENU");
        	}

        }

        /**
         *	앱에 대한 정보를 가져온다.
         **/
        this.fs_appVersion =  undefined;
        this.fn_getAppInfo = function ()
        {
        // 모바일런타임 전환으로
        // 	var callbackName = "fn_callbackGetAppInfo";
        // 	this.fspmob_getAppInfo(this, callbackName);
        	this.fspmob.getAppInfo();
        }

        
        // Transaction callback
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {
        		// 로그인
                case "getAuth" :
        			// 권한에 따른 메뉴 필터링
        			this.fn_menuAuth();
        			break;
        		case "getMenuAuth" :
        			// 권한에 따른 메뉴 필터링
        			this.fn_setAuthProcess();				
        			
        			// 디바이스 정보 담기
        			this.fn_getAppInfo();			
        					
        			break;	
        		case "getMenuAuthList" :
        			
        			application.goMenu.fn_init();
        			this.divRMenu.fn_init();
        			
        			break;	
        		case "logout" :
        			
        			//로그아웃전 데이터셋 초기화
        			application.gds_menu.clearData();
        			application.gds_marketList.clearData();
        			application.gds_marketFicsList.clearData();			
        			
        			if(this.gubun == "logout"){
        				this.fn_actionMain("AFTERLOGOUT");
        			}else if(this.gubun == "exit"){
        				application.exit();
        			}			
        			break;
        		case "getCmnAuth" :
        			application.gv_progrmId = "";			
        			break;
        		case "loginAppDvicUpdate" :	
        			application.goMain.fn_localSave();			
        			break;
        		case "dualUpjang" :	
        			this.fn_getAuth();				
        			break;				
        						
            }
        }

        /** fsp callback 함수 (fsp_callbackFileUpload)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수 (파일 업로드 처리 결과)
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.fsp_callbackBrowser = function (errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);		
        		return false;
        	}
        	else
        	{
        		trace("성공");
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
        		if(this.ds_commonCd.getRowCount() > 0 )
        		{
        			var strMsg;
        			strMsg = "시스템 작업 중입니다. \n"
        				   + "(사용불가시간 => " + this.ds_commonCd.getColumn(0, "set1") + " ~ " + this.ds_commonCd.getColumn(0, "set2") + ")\n"
        				   + "시스템 개선사항 반영을 위해 시스템 종료하오니 상기 작업 시간 이후 재접속을 부탁드립니다.";

        			application.goMain.gfn_Msg("NOTICE", "알림", strMsg, "OK", true, this);			
        		}		
        	}
        	
        	if (id == "NOTICE") // 공지 팝업 콜백
        	{
        		//앱종료
        		application.goMain.fn_action("EXIT");
        	}
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callBackPOP = function (popname,rtn)
        {
        	trace("callbackPOP !!" + popname);
        	switch (popname)
        	{
        		case "Login":
        			trace(rtn);
        			if (rtn == "login success")
        			{
        				//메세지 공통 코드 호출
        				this.fn_common_code("SYS_CLS_PRD", "SYS","","","AND TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') BETWEEN REPLACE(REPLACE(REPLACE(SET1,'/',''),' ',''),':','') AND REPLACE(REPLACE(REPLACE(SET2,'/',''),' ',''),':','')");
        				this.ds_commonCd.copyData(application.gds_common_code);
        				
        				//App정보 갱신
        				application.goMain.fn_action("INIT");	// Menu까지 조회 후로 이동
        				application.goMain.gfn_Msg("ALERT_0", "Information", application.g_Cc_Nm+"\n"+application.g_Name+"님 로그인에 성공하였습니다.", "OK", true, this);
        				
        				//복수업장
        				this.fn_dualUpjang();	
        				
        			}
        			break;
        		case "divRMenu":
        			if (rtn == "Setting")
        			{
        				application.goMain.fn_action("SETTING");
        			}
        			else
        			{
        				application.goMain.fn_action("SUBMENU");
        			}
        			break;		
        	}
        }

        /****************************************************
         * 콜백 : 앱 설정에 대한 정보를 가져온다.
         *****************************************************/
        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_success = function(obj,e)
        {
        	if (e.reason == 0)	// getAppInfo
        	{
        		try{
        			this.ds_appDivcList.clearData();
        			this.ds_appDivcList.addRow();
        			//개발서버일경우 APP정보가 다름			
        			if(application.gv_runMode2 == "D")
        			{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"appId", "12"); //FSP관리자에서 앱ID정보는 정책상 리턴을 안해주기때문에 생성된 appID를 직접 넘긴다.
        			}
        			//운영서버일경우 APP정보가 다름
        			else if(application.gv_runMode2 == "S")
        			{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"appId", "10"); //FSP관리자에서 앱ID정보는 정책상 리턴을 안해주기때문에 생성된 appID를 직접 넘긴다.
        			}				
        			this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"userId", application.g_userId);
        			this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"dvicId", e.returnvalue.deviceID);	
        			
        			// 자동로그인	
        			if(application.gv_autoLogin == "true" || application.gv_autoLogin == true)
        			{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"autoLoginYn", "Y");	
        			}else{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"autoLoginYn", "N");	
        			}	
        			
        			//아이디저장
        			if(application.gv_saveId == "true" || application.gv_saveId == true)
        			{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"saveIdYn", "Y");	
        			}else{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"saveIdYn", "N");	
        			}
        			
        			//아이디저장
        			if(application.gv_pushChk == "true" || application.gv_pushChk == true)
        			{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"pushYn", "Y");	
        			}else{
        				this.ds_appDivcList.setColumn(this.ds_appDivcList.rowposition,"pushYn", "N");	
        			}			
        			
        			//로그인 시 앱 정보 갱신
        			this.fn_loginAppDvicUpdate();		
        		}
        		catch (e) {
        			trace("실패" + e);
        		}
        	}
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_error = function(obj,e)
        {
        	if (e.reason == 0)
        	{
        // 		var obj = this.ta0;
        // 		obj.set_value(e.reason + " : " + e.errormsg );
        		this.trace("앱 초기화에 실패했습니다. 다시 시작해 주십시오.");
        		
        		this.trace(e.errormsg);
        	}
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameMain_onload, this);

        };

        this.loadIncludeScript("CmmnFrameMain.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
