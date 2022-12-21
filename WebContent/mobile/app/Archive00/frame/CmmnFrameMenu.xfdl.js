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
                this.set_name("CmmnFrameMenu");
                this.set_titletext("Menu Frame");
                this.set_scrollbars("autoboth");
                this._setFormPosition(0,0,540,833);
            }
            this.style.set_background("#ffffffff");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_menu", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"sysId\" type=\"STRING\" size=\"256\"/><Column id=\"sysName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"parentMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"prgId\" type=\"STRING\" size=\"256\"/><Column id=\"prgName\" type=\"STRING\" size=\"256\"/><Column id=\"prgPath\" type=\"STRING\" size=\"256\"/><Column id=\"menuType\" type=\"STRING\" size=\"256\"/><Column id=\"levels\" type=\"STRING\" size=\"256\"/><Column id=\"sortSeq\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"prgType\" type=\"STRING\" size=\"256\"/><Column id=\"leaderMenu\" type=\"STRING\" size=\"256\"/><Column id=\"isLeaf\" type=\"INT\" size=\"256\"/><Column id=\"callParam\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_subMenu", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"sysId\" type=\"STRING\" size=\"256\"/><Column id=\"sysName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"parentMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"prgId\" type=\"STRING\" size=\"256\"/><Column id=\"prgName\" type=\"STRING\" size=\"256\"/><Column id=\"prgPath\" type=\"STRING\" size=\"256\"/><Column id=\"menuType\" type=\"STRING\" size=\"256\"/><Column id=\"levels\" type=\"STRING\" size=\"256\"/><Column id=\"sortSeq\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"prgType\" type=\"STRING\" size=\"256\"/><Column id=\"leaderMenu\" type=\"STRING\" size=\"256\"/><Column id=\"isLeaf\" type=\"INT\" size=\"256\"/><Column id=\"callParam\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cboDeviceTest", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"url\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">Camera</Col><Col id=\"url\">sample::frmSampleGetPicture.xfdl</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">Map</Col><Col id=\"url\">sample::frmSampleGPSMap.xfdl</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">Call</Col><Col id=\"url\">sample::frmSampleCall.xfdl</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Div("divMenu", "absolute", "0", "73", "540", "760", null, null, this);
            obj.set_taborder("19");
            obj.set_scrollbars("autovert");
            obj.set_visible("true");
            obj.set_async("false");
            this.addChild(obj.name, obj);
            obj = new Div("divMenu01", "absolute", "0", "295", "100%", "155", null, null, this.divMenu);
            obj.set_taborder("0");
            obj.set_visible("true");
            obj.set_async("false");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("btnMenu01", "absolute", "0", "0", "180", "155", null, null, this.divMenu.divMenu01);
            obj.set_taborder("3");
            obj.set_cssclass("btn_MAIN_Menu01");
            obj.set_visible("false");
            this.divMenu.divMenu01.addChild(obj.name, obj);
            obj = new Button("btnMenu02", "absolute", "180", "0", "180", "155", null, null, this.divMenu.divMenu01);
            obj.set_taborder("4");
            obj.set_cssclass("btn_MAIN_Menu02");
            obj.set_visible("false");
            this.divMenu.divMenu01.addChild(obj.name, obj);
            obj = new Button("btnMenu03", "absolute", "360", "0", "179", "155", null, null, this.divMenu.divMenu01);
            obj.set_taborder("5");
            obj.set_cssclass("btn_MAIN_Menu03");
            obj.set_visible("false");
            this.divMenu.divMenu01.addChild(obj.name, obj);
            obj = new Div("divMenu02", "absolute", "0", "450", "100%", "155", null, null, this.divMenu);
            obj.set_taborder("1");
            obj.set_visible("true");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("btnMenu06", "absolute", "360", "0", "179", "155", null, null, this.divMenu.divMenu02);
            obj.set_taborder("3");
            obj.set_cssclass("btn_MAIN_Menu06");
            obj.set_visible("false");
            this.divMenu.divMenu02.addChild(obj.name, obj);
            obj = new Button("btnMenu05", "absolute", "180", "0", "180", "155", null, null, this.divMenu.divMenu02);
            obj.set_taborder("4");
            obj.set_visible("false");
            obj.set_cssclass("btn_MAIN_Menu05");
            this.divMenu.divMenu02.addChild(obj.name, obj);
            obj = new Button("btnMenu04", "absolute", "0", "0", "180", "155", null, null, this.divMenu.divMenu02);
            obj.set_taborder("5");
            obj.set_visible("false");
            obj.set_cssclass("btn_MAIN_Menu04");
            this.divMenu.divMenu02.addChild(obj.name, obj);
            obj = new Div("divMenu03", "absolute", "0", "605", "100%", "155", null, null, this.divMenu);
            obj.set_taborder("2");
            obj.set_visible("true");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("btnMenu09", "absolute", "360", "0", "179", "155", null, null, this.divMenu.divMenu03);
            obj.set_taborder("3");
            obj.set_cssclass("btn_MAIN_Menu09");
            obj.set_visible("false");
            this.divMenu.divMenu03.addChild(obj.name, obj);
            obj = new Button("btnMenu08", "absolute", "180", "0", "180", "155", null, null, this.divMenu.divMenu03);
            obj.set_taborder("4");
            obj.set_visible("false");
            obj.set_cssclass("btn_MAIN_Menu08");
            this.divMenu.divMenu03.addChild(obj.name, obj);
            obj = new Button("btnMenu07", "absolute", "0", "0", "180", "155", null, null, this.divMenu.divMenu03);
            obj.set_taborder("5");
            obj.set_visible("false");
            obj.set_cssclass("btn_MAIN_Menu07");
            this.divMenu.divMenu03.addChild(obj.name, obj);
            obj = new Static("staWelcomeMsg", "absolute", "0", "0", null, "62", "0", null, this.divMenu);
            obj.set_taborder("4");
            obj.set_text("외식담당자님 로그인 하셨습니다");
            obj.set_cssclass("sta_MAIN_WelcomeBg");
            obj.set_wordwrap("char");
            this.divMenu.addChild(obj.name, obj);
            obj = new Static("sta_backImage", "absolute", "0", "62", null, "233", "0", null, this.divMenu);
            obj.set_taborder("5");
            obj.set_cssclass("sta_MAIN_BgImg");
            this.divMenu.addChild(obj.name, obj);
            obj = new Div("divSubMenu", "absolute", "0", "128", "540", "219", null, null, this.divMenu);
            obj.set_taborder("6");
            obj.set_visible("false");
            obj.style.set_background("#f57f50ff");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu01", "absolute", "2.78%", "17", null, "55", "67.22%", null, this.divMenu.divSubMenu);
            obj.set_taborder("6");
            obj.set_text("추가발주");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu02", "absolute", "35%", "17", null, "55", "35%", null, this.divMenu.divSubMenu);
            obj.set_taborder("7");
            obj.set_text("추가발주취소");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu03", "absolute", "67.22%", "17", null, "55", "2.78%", null, this.divMenu.divSubMenu);
            obj.set_taborder("8");
            obj.set_text("추가발주현황");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu06", "absolute", "67.22%", "83", null, "55", "2.78%", null, this.divMenu.divSubMenu);
            obj.set_taborder("9");
            obj.set_text("발주반려현황");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu05", "absolute", "35%", "83", null, "55", "35%", null, this.divMenu.divSubMenu);
            obj.set_taborder("10");
            obj.set_text("일일발주내역");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu04", "absolute", "2.78%", "83", null, "55", "67.22%", null, this.divMenu.divSubMenu);
            obj.set_taborder("11");
            obj.set_text("상품발주");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu09", "absolute", "67.22%", "149", null, "55", "2.78%", null, this.divMenu.divSubMenu);
            obj.set_taborder("12");
            obj.set_text("발주반려현황");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu08", "absolute", "35%", "149", null, "55", "35%", null, this.divMenu.divSubMenu);
            obj.set_taborder("13");
            obj.set_text("일일발주내역");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Button("btnSubMenu07", "absolute", "2.78%", "149", null, "55", "67.22%", null, this.divMenu.divSubMenu);
            obj.set_taborder("14");
            obj.set_text("상품발주");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            obj.set_visible("false");
            this.divMenu.divSubMenu.addChild(obj.name, obj);
            obj = new Div("divMenu04", "absolute", "0%", "760", null, "155", "0.19%", null, this.divMenu);
            obj.set_taborder("7");
            obj.set_visible("false");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("btnMenu12", "absolute", "66.67%", "0", "179", "155", null, null, this.divMenu.divMenu04);
            obj.set_taborder("6");
            obj.set_cssclass("btn_MAIN_Menu11");
            obj.set_visible("false");
            this.divMenu.divMenu04.addChild(obj.name, obj);
            obj = new Button("btnMenu11", "absolute", "33.33%", "0", "180", "155", null, null, this.divMenu.divMenu04);
            obj.set_taborder("7");
            obj.set_cssclass("btn_MAIN_Menu11");
            obj.set_visible("false");
            this.divMenu.divMenu04.addChild(obj.name, obj);
            obj = new Button("btnMenu10", "absolute", "0%", "0", "180", "155", null, null, this.divMenu.divMenu04);
            obj.set_taborder("8");
            obj.set_cssclass("btn_MAIN_Menu10");
            obj.set_visible("false");
            this.divMenu.divMenu04.addChild(obj.name, obj);
            obj = new Button("Button00", "absolute", "2.78%", "69", null, "50", "75%", null, this.divMenu);
            obj.set_taborder("8");
            obj.set_text("TEST1");
            obj.set_visible("false");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("Button01", "absolute", "26.48%", "69", null, "50", "51.3%", null, this.divMenu);
            obj.set_taborder("9");
            obj.set_text("TEST2");
            obj.set_visible("false");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", "50.19%", "69", null, "50", "27.59%", null, this.divMenu);
            obj.set_taborder("10");
            obj.set_text("TEST3");
            obj.set_visible("false");
            this.divMenu.addChild(obj.name, obj);
            obj = new Button("Button04", "absolute", "73.89%", "69", null, "50", "3.89%", null, this.divMenu);
            obj.set_taborder("12");
            obj.set_text("TEST4");
            obj.set_visible("false");
            this.divMenu.addChild(obj.name, obj);

            obj = new Div("divMenuTop", "absolute", "0", "0", null, "73", "0", null, this);
            obj.set_taborder("21");
            obj.set_scrollbars("none");
            obj.set_visible("true");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.divMenu.divMenu01,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("0");
            		p.set_visible("true");
            		p.set_async("false");

            	}
            );
            this.divMenu.divMenu01.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.divMenu.divMenu02,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("1");
            		p.set_visible("true");

            	}
            );
            this.divMenu.divMenu02.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.divMenu.divMenu03,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("2");
            		p.set_visible("true");

            	}
            );
            this.divMenu.divMenu03.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 219, this.divMenu.divSubMenu,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("6");
            		p.set_visible("false");
            		p.style.set_background("#f57f50ff");

            	}
            );
            this.divMenu.divSubMenu.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.divMenu.divMenu04,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("7");
            		p.set_visible("false");

            	}
            );
            this.divMenu.divMenu04.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this.divMenu,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("19");
            		p.set_scrollbars("autovert");
            		p.set_visible("true");
            		p.set_async("false");

            	}
            );
            this.divMenu.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "ScreenPad,ScreenPhone", 540, 833, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameMenu");
            		p.set_titletext("Menu Frame");
            		p.set_scrollbars("autoboth");
            		p.style.set_background("#ffffffff");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnFrameMenu.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("CmmnFrameMenu.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 메인메뉴
        // [프로그램]		CmmnFrameMain.xfdl
        // [설명]
        // 		프로젝트 실행 메인메뉴 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"

        this.f_sSetFlag;

        this.CmmnFrameMenu_onload = function(obj,e)
        {
        	application.goMenu = this;
        	
        	this.fn_init();
        	
        	this.divMenuTop.set_url("frame::CmmnFrameTop.xfdl");
        }

        this.fn_init = function()
        {
        	//뒤로가기 체크를 위한 cnt 추가
        	application.gvWaitCount = 0;
        	
        	// 로그인 환영 메세지 셋팅
        	this.divMenu.staWelcomeMsg.set_text(application.g_UpjangNm+" "+application.g_Name+"님 로그인 하셨습니다");	
        	//trace("application.gds_menu :: " +application.gds_menu.saveXML("gds_menu", "V"));
        	// menu복사 및 필터링
        	this.ds_menu.clearData();	
        	this.ds_menu.copyData(application.gds_menu, true);
        	this.ds_subMenu.clearData();
        	this.ds_subMenu.copyData(application.gds_menu, true);
        	
        	this.ds_menu.filter("levels == '0'");
        	this.ds_subMenu.filter("levels == '1'");
        	
        	if (this.ds_menu.rowcount > 9)
        	{
        		this.divMenu.divMenu04.set_visible(true);
        	}
        	this.fn_menuSetting();
        	
        	this.resetScroll();
        }

        // 매인메뉴셋팅
        this.fn_menuSetting = function()
        {
        	var nRow = this.ds_menu.rowcount;
        	var i;
        	var objDiv;
        	var objBtn;
        	
        	for (i = 0; i < nRow; i++)
        	{
        		objDiv = this.divMenu.components["divMenu0"+(nexacro.floor(i/3)+1)];
        		objBtn = objDiv.components["btnMenu"+application.goMain.gfn_LPad((i+1).toString(), "0", 2)];
        		objBtn.set_visible(true);
        		
        		// cssclass 설정
        		switch (this.ds_menu.getColumn(i, "sysName"))
        		{
        			case "발주관리" :	// 발주관리
        				objBtn.set_cssclass("btn_MAIN_Menu01");
        				break;
        			case "재고관리" :	// 재고관리
        				objBtn.set_cssclass("btn_MAIN_Menu02");
        				break;
        			case "상품정보" :	// 상품정보
        				objBtn.set_cssclass("btn_MAIN_Menu03");
        				break;
        			case "E-FOODIST" :	//  E-FOODIST
        				objBtn.set_cssclass("btn_MAIN_Menu04");
        				break;
        			case "여신관리" :	// 여신관리
        				objBtn.set_cssclass("btn_MAIN_Menu11");
        				break;
        			case "영업관리" :	// 영업관리
        				objBtn.set_cssclass("btn_MAIN_Menu09");
        				break;
        			case "팀장승인" :	// 팀장승인
        				objBtn.set_cssclass("btn_MAIN_Menu05");
        				break;
        			case "클레임관리" :	// 클레임관리
        				objBtn.set_cssclass("btn_MAIN_Menu06");
        				break;
        			case "웨딩예약" :	// 웨딩예약
        				objBtn.set_cssclass("btn_MAIN_Menu07");
        				break;
        			case "이미지전송" :	// 위생관리
        				objBtn.set_cssclass("btn_MAIN_Menu08");
        				break;
        			case "게시판" :	// 게시판
        				objBtn.set_cssclass("btn_MAIN_Menu10");
        				break;
        		}
        		
        		// objBtn.set_cssclass(this.ds_menu.getColumn(i, "cssclass"));
        	}
        	
        	this.divMenu.resetScroll();
        }

        // 매인메뉴 클릭 시 동작
        this.mainMenu_onclick = function(obj,e)
        {
        	this.ds_subMenu.filter("");
        	
        	switch (application.goMain.gfn_Right(obj.cssclass, 2))
        	{
        		case "01" :	// 발주관리
        			this.ds_subMenu.filter("sysName == '발주관리' && levels == '1'");
        			break;
        		case "02" :	// 재고관리
        			this.ds_subMenu.filter("sysName == '재고관리' && levels == '1'");
        			break;
        		case "03" :	// 상품정보
        			this.ds_subMenu.filter("sysName == '상품정보' && levels == '1'");	
        			break;
        		case "04" :	//  E-FOODIST
        			this.ds_subMenu.filter("sysName == 'E-FOODIST' && levels == '1'");
        			break;
        		case "11" :	// 여신관리
        			this.ds_subMenu.filter("sysName == '여신관리' && levels == '1'");
        			break;
        		case "09" :	// 영업관리
        			this.ds_subMenu.filter("sysName == '영업관리' && levels == '1'");
        			break;
        		case "05" :	// 팀장승인
        			this.ds_subMenu.filter("sysName == '팀장승인' && levels == '1'");
        			break;
        		case "06" :	// 클레임관리
        			this.ds_subMenu.filter("sysName == '클레임관리' && levels == '1'");
        			break;
        		case "07" :	// 웨딩예약
        			this.ds_subMenu.filter("sysName == '웨딩예약' && levels == '1'");
        			break;
        		case "08" :	// 이미지전송
        			this.ds_subMenu.filter("sysName == '이미지전송' && levels == '1'");
        			break;
        		case "10" :	// 게시판
        			this.ds_subMenu.filter("sysName == '게시판' && isLeaf == '0'");
        			break;
        	}	
        	
        	// 서브메뉴가 하나일경우 바로 페이지로 이동
        	if(this.ds_subMenu.getRowCount() == "1")
        	{
        	
        		this.fn_goPage();
        		
        	}else{
        		if (obj.parent.name == "divMenu01")
        		{
        			// 메뉴 cssclass를 기준으로 토글
        			if (application.goMain.gfn_Right(obj.cssclass, 1) != "S")
        			{
        				// 서브메뉴 셋팅
        				// 서브메뉴 dataset필터
        				this.fn_subMenuSetting(obj.cssclass);
        			
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				// 모든 메뉴 cssclass 리셋
        				this.fn_menuBtnReset();
        				// 서브 보여주기
        				this.divMenu.divSubMenu.set_top(this.divMenu.divMenu01.getOffsetBottom());
        				this.divMenu.divSubMenu.set_visible(true);
        				// 다른 메뉴 밀기
        				this.divMenu.divMenu02.set_top(parseInt(this.divMenu.divMenu01.getOffsetBottom())+parseInt(this.divMenu.divSubMenu.getOffsetHeight()));
        				this.divMenu.divMenu03.set_top(parseInt(this.divMenu.divMenu02.getOffsetBottom()));
        				this.divMenu.divMenu04.set_top(parseInt(this.divMenu.divMenu03.getOffsetBottom()));
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass + "S");
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				// 서브메뉴에 포커스(스크롤이동 효과)
        				this.divMenu.divSubMenu.setFocus();
        			}
        			else
        			{
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				this.divMenu.divMenu01.setFocus();
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass.substr(0, obj.cssclass.length-1));
        			}
        		}
        		if (obj.parent.name == "divMenu02")
        		{
        			// 메뉴 cssclass를 기준으로 토글
        			if (application.goMain.gfn_Right(obj.cssclass, 1) != "S")
        			{
        				// 서브메뉴 셋팅
        				// 서브메뉴 dataset필터
        				this.fn_subMenuSetting(obj.cssclass);
        			
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				// 모든 메뉴 cssclass 리셋
        				this.fn_menuBtnReset();
        				// 서브 보여주기
        				this.divMenu.divSubMenu.set_top(this.divMenu.divMenu02.getOffsetBottom());
        				this.divMenu.divSubMenu.set_visible(true);
        				// 다른 메뉴 밀기
        				this.divMenu.divMenu03.set_top(parseInt(this.divMenu.divMenu02.getOffsetBottom())+parseInt(this.divMenu.divSubMenu.getOffsetHeight()));
        				this.divMenu.divMenu04.set_top(parseInt(this.divMenu.divMenu03.getOffsetBottom()));
        				
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass + "S");
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				// 서브메뉴에 포커스(스크롤이동 효과)
        				this.divMenu.divSubMenu.setFocus();
        			}
        			else
        			{
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				this.divMenu.divMenu02.setFocus();
        			
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass.substr(0, obj.cssclass.length-1));
        			}
        		}
        		if (obj.parent.name == "divMenu03")
        		{
        			// 메뉴 cssclass를 기준으로 토글
        			if (application.goMain.gfn_Right(obj.cssclass, 1) != "S")
        			{
        				// 서브메뉴 셋팅
        				// 서브메뉴 dataset필터
        				this.fn_subMenuSetting(obj.cssclass);
        			
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				// 모든 메뉴 cssclass 리셋
        				this.fn_menuBtnReset();
        				// 서브 보여주기
        				this.divMenu.divSubMenu.set_top(this.divMenu.divMenu03.getOffsetBottom());
        				this.divMenu.divSubMenu.set_visible(true);
        				// 다른 메뉴 밀기
        				this.divMenu.divMenu04.set_top(parseInt(this.divMenu.divMenu03.getOffsetBottom())+parseInt(this.divMenu.divSubMenu.getOffsetHeight()));
        				
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass + "S");
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				// 서브메뉴에 포커스(스크롤이동 효과)
        				this.divMenu.divSubMenu.setFocus();
        			}
        			else
        			{
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				this.divMenu.divMenu03.setFocus();
        			
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass.substr(0, obj.cssclass.length-1));
        			}
        		}
        		if (obj.parent.name == "divMenu04")
        		{
        			// 메뉴 cssclass를 기준으로 토글
        			if (application.goMain.gfn_Right(obj.cssclass, 1) != "S")
        			{
        				// 서브메뉴 셋팅
        				// 서브메뉴 dataset필터
        				this.fn_subMenuSetting(obj.cssclass);
        			
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				// 모든 메뉴 cssclass 리셋
        				this.fn_menuBtnReset();
        				// 서브 보여주기
        				this.divMenu.divSubMenu.set_top(this.divMenu.divMenu04.getOffsetBottom());
        				this.divMenu.divSubMenu.set_visible(true);
        				
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass + "S");
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				// 서브메뉴에 포커스(스크롤이동 효과)
        				this.divMenu.divSubMenu.setFocus();
        			}
        			else
        			{
        				// 메뉴 원래대로
        				this.fn_menuReset();
        				
        				// 스크롤 리셋
        				this.divMenu.resetScroll();
        				
        				this.divMenu.divMenu04.setFocus();
        			
        				// 메뉴 cssclass 변경
        				obj.set_cssclass(obj.cssclass.substr(0, obj.cssclass.length-1));
        			}
        		}	
        	}	
        }

        // 서브메뉴 클릭 시 동작
        this.divMenu_divSubMenu_btnSubMenu_onclick = function(obj,e)
        {
        	var nRow = parseInt(application.goMain.gfn_Right(obj.id, 2))-1;	
        	
        	// action 실행
        	application.gv_menuId = this.ds_subMenu.getColumn(nRow, "menuId");
        	application.gv_formUrl = this.ds_subMenu.getColumn(nRow, "prgPath");
        	application.gv_menuName = this.ds_subMenu.getColumn(nRow, "menuName");
        	application.gv_progrmId = this.ds_subMenu.getColumn(nRow, "prgId");
        	
        	// 메뉴이동전 메뉴정보 글로벌 변수에 담기
        	application.gv_menuBefId = this.ds_subMenu.getColumn(nRow, "menuId");
        	application.gv_formBefUrl = this.ds_subMenu.getColumn(nRow, "prgPath");
        	application.gv_menuBefName = this.ds_subMenu.getColumn(nRow, "menuName");
        	application.gv_progrmBefId = this.ds_subMenu.getColumn(nRow, "prgId");
        	
        	application.goMain.fn_action("SUBMENU");
        }

        // 서브메뉴가 하나일경우 바로 페이지로 이동
        this.fn_goPage = function ()
        {
        	// action 실행
        	application.gv_menuId = this.ds_subMenu.getColumn(0, "menuId");
        	application.gv_formUrl = this.ds_subMenu.getColumn(0, "prgPath");
        	application.gv_menuName = this.ds_subMenu.getColumn(0, "menuName");
        	application.gv_progrmId = this.ds_subMenu.getColumn(0, "prgId");
        	
        	// 메뉴이동전 메뉴정보 글로벌 변수에 담기
        	application.gv_menuBefId = this.ds_subMenu.getColumn(0, "menuId");
        	application.gv_formBefUrl = this.ds_subMenu.getColumn(0, "prgPath");
        	application.gv_menuBefName = this.ds_subMenu.getColumn(0, "menuName");
        	application.gv_progrmBefId = this.ds_subMenu.getColumn(0, "prgId");	
        	
        	application.goMain.fn_action("SUBMENU");
        	
        }

        // 서브메뉴 셋팅
        this.fn_subMenuSetting = function (sCssClass)
        {
        	//trace("서브메뉴셋팅 : "+application.goMain.gfn_Right(sCssClass, 2));
        	this.ds_subMenu.filter("");
        	switch (application.goMain.gfn_Right(sCssClass, 2))
        	{
        		case "01" :	// 발주관리
        			this.ds_subMenu.filter("sysName == '발주관리' && levels == '1'");
        			break;
        		case "02" :	// 재고관리
        			this.ds_subMenu.filter("sysName == '재고관리' && levels == '1'");
        			break;
        		case "03" :	// 상품정보
        			this.ds_subMenu.filter("sysName == '상품정보' && levels == '1'");	
        			break;
        		case "04" :	//  E-FOODIST
        			this.ds_subMenu.filter("sysName == 'E-FOODIST' && levels == '1'");
        			break;
        		case "11" :	// 여신관리
        			this.ds_subMenu.filter("sysName == '여신관리' && levels == '1'");
        			break;
        		case "09" :	// 영업관리
        			this.ds_subMenu.filter("sysName == '영업관리' && levels == '1'");
        			break;
        		case "05" :	// 팀장승인
        			this.ds_subMenu.filter("sysName == '팀장승인' && levels == '1'");
        			break;
        		case "06" :	// 클레임관리
        			this.ds_subMenu.filter("sysName == '클레임관리' && levels == '1'");
        			break;
        		case "07" :	// 웨딩예약
        			this.ds_subMenu.filter("sysName == '웨딩예약' && levels == '1'");
        			break;
        		case "08" :	// 위생관리
        			this.ds_subMenu.filter("sysName == '이미지전송' && levels == '1'");
        			break;
        		case "10" :	// 게시판
        			this.ds_subMenu.filter("sysName == '게시판' && levels == '1'");
        			break;
        	}
        	
        	// subMenu동적 셋팅
        	var nRow = this.ds_subMenu.rowcount;
        	var i;
        	var objDiv;
        	var objBtn;
        	// subMenu버튼 visible false로 만들기
        	for (i = 0; i < 9; i++)
        	{
        		objDiv = this.divMenu.divSubMenu;
        		objBtn = objDiv.components["btnSubMenu"+application.goMain.gfn_LPad((i+1).toString(), "0", 2)];
        		objBtn.set_visible(false);
        	}
        	for (i = 0; i < nRow; i++)
        	{
        		objDiv = this.divMenu.divSubMenu;
        		objBtn = objDiv.components["btnSubMenu"+application.goMain.gfn_LPad((i+1).toString(), "0", 2)];
        		objBtn.set_visible(true);
        		objBtn.set_text(this.ds_subMenu.getColumn(i, "menuName"));
        	}
        	if (nRow >= 1 && nRow <= 3)
        	{
        		objDiv.set_height(17 + 55 + 17);
        	}
        	else if (nRow >= 4 && nRow <= 6)
        	{
        		objDiv.set_height(83 + 55 + 17);
        	}
        	else if (nRow >= 7 && nRow <= 9)
        	{
        		objDiv.set_height(149 + 55 + 17);
        	}
        }

        // 모든 메뉴를 원래대로
        this.fn_menuReset = function()
        {
        	// 서브 감추기
        	this.divMenu.divSubMenu.set_visible(false);
        	// 모든 메뉴 위치 원래대로
        	this.divMenu.divMenu02.set_top(parseInt(this.divMenu.divMenu01.getOffsetBottom()));
        	this.divMenu.divMenu03.set_top(parseInt(this.divMenu.divMenu02.getOffsetBottom()));
        	this.divMenu.divMenu04.set_top(parseInt(this.divMenu.divMenu03.getOffsetBottom()));
        }

        // 모든 메뉴의 cssclass를 원래대로
        this.fn_menuBtnReset = function()
        {
        	this.fn_menuSetting();
        }

        // ==================================
        // TEST 버튼들

        this.divMenu_Button00_onclick = function(obj,e)
        {
        	application.goMain.fn_action("TEST");
        }

        this.divMenu_Button01_onclick = function(obj,e)
        {
        	application.goMain.fn_action("TEST2");
        }

        this.divMenu_Button02_onclick = function(obj,e)
        {
        	application.goMain.fn_action("TEST3");
        }

        this.divMenu_Button03_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_cboDeviceTest;
        	arg[1] = "DeviceTest";
        	arg[2] = "";
        	arg[3] = "name";
        	application.goMain.gfn_POP_create("DeviceTest", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        //	return false;
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	trace(rtn);
        	switch (popname)
        	{
        		case "DeviceTest":
        			application.gv_backFlag = "MENU";
        			application.gv_menuId = "DeviceTest";
        			application.gv_menuName = this.ds_cboDeviceTest.getColumn(rtn, "name");
        			application.gv_formUrl = this.ds_cboDeviceTest.getColumn(rtn, "url");
        			application.goMain.fn_action("DeviceTest");
        // 			this.divMain.set_url("");
        // 			this.divMain.set_url("frame::CmmnFrameSub.xfdl");
        // 			this.divMain.bringToFront();
        			break;
        			break;
        	}
        }
        this.divMenu_Button04_onclick = function(obj,e)
        {
        	application.goMain.fn_action("TEST4");
        }

        this.divMenu_staWelcomeMsg_onclick = function(obj,e)
        {
        	if ( application.g_userId == "Z1855902" ) {
        		if( !this.divMenu.divSubMenu.cssclass || this.divMenu.divSubMenu.cssclass == null ) {
        			this.divMenu.divSubMenu.set_cssclass("div_MAIN_2DepthMenuBg");
        		} else {
        			this.divMenu.divSubMenu.set_cssclass("");
        		}
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameMenu_onload, this);
            this.divMenu.divMenu01.btnMenu01.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu01.btnMenu02.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu01.btnMenu03.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu02.btnMenu06.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu02.btnMenu05.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu02.btnMenu04.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu03.btnMenu09.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu03.btnMenu08.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu03.btnMenu07.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.staWelcomeMsg.addEventHandler("onclick", this.divMenu_staWelcomeMsg_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu01.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu02.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu03.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu06.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu05.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu04.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu09.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu08.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divSubMenu.btnSubMenu07.addEventHandler("onclick", this.divMenu_divSubMenu_btnSubMenu_onclick, this);
            this.divMenu.divMenu04.btnMenu12.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu04.btnMenu11.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.divMenu04.btnMenu10.addEventHandler("onclick", this.mainMenu_onclick, this);
            this.divMenu.Button00.addEventHandler("onclick", this.divMenu_Button00_onclick, this);
            this.divMenu.Button01.addEventHandler("onclick", this.divMenu_Button01_onclick, this);
            this.divMenu.Button02.addEventHandler("onclick", this.divMenu_Button02_onclick, this);
            this.divMenu.Button04.addEventHandler("onclick", this.divMenu_Button04_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameMenu.xfdl", true);

       
    };
}
)();
