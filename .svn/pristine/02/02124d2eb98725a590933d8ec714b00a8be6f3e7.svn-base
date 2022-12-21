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
                this.set_name("CmmnFrameTop");
                this.set_titletext("Top Frame");
                this.set_scrollbars("none");
                this._setFormPosition(0,0,540,73);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"SINGLE_ID\" size=\"255\" type=\"STRING\"/><Column id=\"ROLE_ID\" size=\"255\" type=\"STRING\"/><Column id=\"MENU_CD\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_menuCond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"SINGLE_ID\" size=\"20\" type=\"STRING\"/><Column id=\"USER_ID\" size=\"20\" type=\"STRING\"/><Column id=\"ROLE_ID\" size=\"10\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staTitle", "absolute", "0", "0", null, "73", "0", null, this);
            obj.set_taborder("2");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias bold 26 Droid Sans");
            obj.set_cssclass("sta_TOP_Bg");
            this.addChild(obj.name, obj);

            obj = new Button("btnPrev", "absolute", "0", "0", "73", "73", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("btn_TOP_Pre");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "0", "73", "73", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("btn_TOP_SubMenu");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 73, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameTop");
            		p.set_titletext("Top Frame");
            		p.set_scrollbars("none");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_cond");
            this._addPreloadList("data", "", "ds_menuCond");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameTop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameTop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - TOP 화면
        // [프로그램]		CmmnFrameTop.xfdl
        // [설명]
        // 		공통 - TOP 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

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
        this.CmmnFrameTop_onload = function(obj,e)
        {
        	this.fsp_init(); // FSP Init.
        	
        	application.goTopSub = this;
        	application.goTopMain = this;	
        	
        	if (this.name == "divMenuTop")
        	{
        		this.fn_showPrev(false);
        		// 타이틀
        		application.gfn_setTitleMain("메인메뉴");
        	}
        	else if (this.name == "divTop")
        	{
        		application.gfn_setTitleMain(application.gv_menuName);
        	}

        }

        this.fn_showPrev = function (parmFlag)
        {
        	this.btnPrev.set_visible(parmFlag);
        }

        //뒤로가기 클릭 시
        this.btnPrev_onclick = function(obj,e)
        {	
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirm", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.fn_back();	
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirm", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.fn_back();	
        		}	
        	}
        	else
        	{
        		application.goMain.fn_back();	
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
        	
        	if (id == "confirm") // 백버튼시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			application.goMainSub.fn_back();	
        		}else if(rtn == "N"){
        			
        		}
        	}
        		
        	if (id == "confirm01") // 사이드(퀵)매뉴시 확인창 콜백
        	{
        		if(rtn == "Y"){
        			application.goMain.fn_action("RIGHTMENU");	
        		}else if(rtn == "N"){
        			
        		}
        	}		
        }

        // 오른쪽 메뉴 생성버튼
        this.staBtnSubMenu_onclick = function(obj,e)
        {
        	if(!this.gfn_isNull(application.goMenu.ds_grd))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd)==true)
        		{	
        			application.goMain.gfn_Msg("confirm01", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.fn_action("RIGHTMENU");	
        		}	
        	}
        	else if(!this.gfn_isNull(application.goMenu.ds_grd1))
        	{
        		if(this.gfn_dsIsUpdated(application.goMenu.ds_grd1)==true)
        		{	
        			application.goMain.gfn_Msg("confirm01", "확인", "변경된 데이터가 있습니다.\n 화면 이동하겠습니까?!", "YN", true, this);	
        		}
        		else
        		{
        			application.goMain.fn_action("RIGHTMENU");	
        		}	
        	}
        	else
        	{
        		application.goMain.fn_action("RIGHTMENU");		
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
        		case "SubMenu":		// 년도
        			
        			break;
        	}
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameTop_onload, this);
            this.btnPrev.addEventHandler("onclick", this.btnPrev_onclick, this);
            this.Button00.addEventHandler("onclick", this.staBtnSubMenu_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameTop.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
