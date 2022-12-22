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
                this.set_name("CmmnFrameBottom");
                this.set_titletext("Bottom Frame");
                this.set_scrollbars("none");
                this._setFormPosition(0,0,540,90);
            }
            this.style.set_background("#ffffffff");

            
            // Object(Dataset, ExcelExportObject) Initialize
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
            obj = new Button("btnHome", "absolute", "0", "0", "108", "90", null, null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_BOTTOM_Home");
            this.addChild(obj.name, obj);

            obj = new Button("btnSetting", "absolute", "216", "0", "108", "90", null, null, this);
            obj.set_taborder("9");
            obj.set_cssclass("btn_BOTTOM_Setup");
            this.addChild(obj.name, obj);

            obj = new Button("btnInfo", "absolute", "108", "0", "108", "90", null, null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_BOTTOM_Info");
            this.addChild(obj.name, obj);

            obj = new Button("btnCart", "absolute", "324", "0", "108", "90", null, null, this);
            obj.set_taborder("11");
            obj.set_cssclass("btn_BOTTOM_Cart");
            this.addChild(obj.name, obj);

            obj = new Button("btnLogout", "absolute", "432", "0", "108", "90", null, null, this);
            obj.set_taborder("12");
            obj.set_cssclass("btn_BOTTOM_Logout");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 90, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameBottom");
            		p.set_titletext("Bottom Frame");
            		p.set_scrollbars("none");
            		p.style.set_background("#ffffffff");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnFrameBottom.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameBottom.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 하단프레임
        // [프로그램]		CmmnFrameBottom.xfdl
        // [설명]
        // 		프로젝트 실행 시 하단에 띄워지는 화면
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
        this.f_sSetFlag;	// 하단 버튼 중복 클릭 안되도록 셋팅
        this.fo_hisPOP = new Array(); //팝업 히스토리

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
        this.CmmnFrameBottom_onload = function(obj,e)
        {
        	this.f_sSetFlag = "HOME";
        	
        	//TODO 변경 필요
        	application.goButtom = this;

        }

        
        /*----------------------------------------------------------------------------------------------
         * 설명      : 로그인 재 팝업
         *---------------------------------------------------------------------------------------------*/
        this.fn_reLogin = function ()
        {
        	var arg = new Array();
        	
        	application.goMain.gfn_POP_create("reLogin", "cmmn::CmmnLoginPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;	
        	
        }

        //HOME 클릭
        this.btnHome_onclick = function(obj,e)
        {
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirmHome", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "HOME" && application.gv_menuId == "HOME" )
        			{
        				application.goMenu.fn_menuReset();			
        			}
        			this.f_sSetFlag = "HOME";
        			application.goMain.fn_action("HOME");	
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirmHome", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "HOME" && application.gv_menuId == "HOME" )
        			{
        				application.goMenu.fn_menuReset();			
        			}
        			this.f_sSetFlag = "HOME";
        			application.goMain.fn_action("HOME");	
        		}	
        	}
        	else
        	{
        		if(this.f_sSetFlag == "HOME" && application.gv_menuId == "HOME" )
        			{
        				application.goMenu.fn_menuReset();			
        			}
        			this.f_sSetFlag = "HOME";
        			application.goMain.fn_action("HOME");		
        	}		
        }

        // Info 버튼 클릭 시
        this.btnInfo_onclick = function(obj,e)
        {	
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirmInfo", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "INFO" && application.gv_menuId == "INFO" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "INFO";
        			application.goMain.fn_action("INFO");
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirmInfo", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "INFO" && application.gv_menuId == "INFO" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "INFO";
        			application.goMain.fn_action("INFO");
        		}	
        	}
        	else
        	{
        		if(this.f_sSetFlag == "INFO" && application.gv_menuId == "INFO" )
        		{
        			return false;
        		}
        		this.f_sSetFlag = "INFO";
        		application.goMain.fn_action("INFO");
        	}
         	
        }

        //Setting 버튼 클릭 시
        this.btnSetting_onclick = function(obj,e)
        {
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirmSetup", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "SETTING" && application.gv_menuId == "SETTING" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "SETTING";
        			application.gv_menuId = "SETTING";
        			application.goMain.fn_action("SETTING");
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirmSetup", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "SETTING" && application.gv_menuId == "SETTING" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "SETTING";
        			application.gv_menuId = "SETTING";
        			application.goMain.fn_action("SETTING");
        		}	
        	}
        	else
        	{
        		if(this.f_sSetFlag == "SETTING" && application.gv_menuId == "SETTING" )
        		{
        			return false;
        		}
        		this.f_sSetFlag = "SETTING";
        		application.gv_menuId = "SETTING";
        		application.goMain.fn_action("SETTING");
        	}	
        }

        // 장바구니 버튼 클릭 시
        this.btnCart_onclick = function(obj,e)
        {
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirmCart", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "CART" && application.gv_menuId == "CART" )
        			{
        				return false;
        			}			
        			this.f_sSetFlag = "CART";
        			application.goMain.fn_action("CART");
        			
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirmCart", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			if(this.f_sSetFlag == "CART" && application.gv_menuId == "CART" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "CART";
        			application.goMain.fn_action("CART");
        		}	
        	}
        	else
        	{
        		if(this.f_sSetFlag == "CART" && application.gv_menuId == "CART" )
        		{
        			return false;
        		}
        		this.f_sSetFlag = "CART";
        		application.goMain.fn_action("CART");
        	}	
        	
        }

        // 로그아웃 버튼 온클릭 !!
        this.btnLogout_onclick = function(obj,e)
        {
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirmLogout", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.gfn_Msg("logout", "로그아웃", "로그아웃 하시겠습니까?", "YN", true, this);
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirmLogout", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.gfn_Msg("logout", "로그아웃", "로그아웃 하시겠습니까?", "YN", true, this);
        		}	
        	}
        	else
        	{
        		application.goMain.gfn_Msg("logout", "로그아웃", "로그아웃 하시겠습니까?", "YN", true, this);
        	}
        	
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "reLogin":
        		if(application.goMain.fo_hisPOP.length < 2)
        		{
        			if(!this.gfn_isNull(application.gv_progrmId))
        			{
        				application.goMain.fn_action("SUBMENU");
        			}
        		}
        		break;		
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
        	if (id == "logout")
        	{
        		if (rtn == "Y") 
        		{
        			application.goMain.fn_action("LOGOUT");			
        		}
        		else
        		{
        			return;
        		}
        	}
        	
        	if (id == "pushPop")
        	{
        		
        	}
        	
        	if (id == "confirmHome") // 홈버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			if(this.f_sSetFlag == "HOME" && application.gv_menuId == "HOME" )
        			{
        				application.goMenu.fn_menuReset();			
        			}
        			this.f_sSetFlag = "HOME";
        			application.goMain.fn_action("HOME");		
        		}else if(rtn == "N"){
        			
        		}
        	}
        	
        	if (id == "confirmInfo") // Info버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			if(this.f_sSetFlag == "INFO" && application.gv_menuId == "INFO" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "INFO";
        			application.goMain.fn_action("INFO");
        		}else if(rtn == "N"){
        			
        		}
        	}
        	
        	if (id == "confirmSetup") // Info버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			if(this.f_sSetFlag == "SETTING" && application.gv_menuId == "SETTING" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "SETTING";
        			application.gv_menuId = "SETTING";
        			application.goMain.fn_action("SETTING");
        		}else if(rtn == "N"){
        			
        		}
        	}
        	
        	if (id == "confirmCart") // Info버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			if(this.f_sSetFlag == "CART" && application.gv_menuId == "CART" )
        			{
        				return false;
        			}
        			this.f_sSetFlag = "CART";
        			application.goMain.fn_action("CART");
        		}else if(rtn == "N"){
        			
        		}
        	}
        	
        	if (id == "confirmLogout") // Info버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			application.goMain.gfn_Msg("logout", "로그아웃", "로그아웃 하시겠습니까?", "YN", true, this);
        		}else if(rtn == "N"){
        			
        		}
        	}
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 수신받은 push알림건 조회
         *---------------------------------------------------------------------------------------------*/
        this.fn_search = function()
        {
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/cmn/mobileCommon/selectPushList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "userId=" + nexacro.wrapQuote(application.g_userId);
        		strArguments	+= " title=" + "";	
        	    strArguments	+= " curPageNum=" + "1";	// TODO 현재 페이지번호 추가
        	    strArguments	+= " pageRow=" + "1";	// TODO 페이지당 건수
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
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
        		//PUSH알림팝업
                case "search" :
        			var arg = new Array();
        			arg[0] = this.ds_grd.getColumn(0, "title");
        			arg[1] = this.ds_grd.getColumn(0, "body");
        			
        			application.goMain.gfn_POP_create("pushPop", "cmmn::CmmnPushPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			return false;
        	
                break;    
            }    
            
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameBottom_onload, this);
            this.btnHome.addEventHandler("onclick", this.btnHome_onclick, this);
            this.btnSetting.addEventHandler("onclick", this.btnSetting_onclick, this);
            this.btnInfo.addEventHandler("onclick", this.btnInfo_onclick, this);
            this.btnCart.addEventHandler("onclick", this.btnCart_onclick, this);
            this.btnLogout.addEventHandler("onclick", this.btnLogout_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameBottom.xfdl", true);

       
    };
}
)();
