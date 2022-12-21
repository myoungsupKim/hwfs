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
                this.set_name("CmmnFrameRightMenu");
                this.set_titletext("사이드메뉴");
                this.set_scrollbars("autovert");
                this._setFormPosition(0,0,330,923);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_radio_N", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><ConstColumn id=\"ConstColumn0\" type=\"STRING\" size=\"30\" value=\"\"/><ConstColumn id=\"ConstColumn1\" type=\"STRING\" size=\"30\" value=\"\"/><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">0</Col><Col id=\"name\">동의합니다.</Col></Row><Row><Col id=\"code\">1</Col><Col id=\"name\">동의하지 않습니다.</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_list", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"SINGLE_ID\" size=\"20\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"SINGLE_ID\" size=\"255\" type=\"STRING\"/><Column id=\"PWD\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_rMenu", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"sysId\" type=\"STRING\" size=\"256\"/><Column id=\"sysName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"parentMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"prgId\" type=\"STRING\" size=\"256\"/><Column id=\"prgName\" type=\"STRING\" size=\"256\"/><Column id=\"prgPath\" type=\"STRING\" size=\"256\"/><Column id=\"menuType\" type=\"STRING\" size=\"256\"/><Column id=\"levels\" type=\"STRING\" size=\"256\"/><Column id=\"sortSeq\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"prgType\" type=\"STRING\" size=\"256\"/><Column id=\"leaderMenu\" type=\"STRING\" size=\"256\"/><Column id=\"isLeaf\" type=\"INT\" size=\"256\"/><Column id=\"callParam\" type=\"STRING\" size=\"256\"/><Column id=\"ALL\" type=\"STRING\" size=\"256\"/><Column id=\"IFIS\" type=\"STRING\" size=\"256\"/><Column id=\"FICS\" type=\"STRING\" size=\"256\"/><Column id=\"isRMenu\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0%", "0", null, "923", "0%", null, this);
            obj.set_taborder("15");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "156", "85", null, null, "0", this);
            obj.set_taborder("12");
            obj.set_cssclass("sta_RF_BtnBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "85", "156", null, null, "0", "0", this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_RF_BtnBg2");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu01", "absolute", "0", "156", null, "71", "0", null, this);
            obj.set_taborder("0");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", null, "156", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_RF_WelcomeBg");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "55", "55", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_RF_Xbtn");
            this.addChild(obj.name, obj);

            obj = new Static("staDept", "absolute", "89", "68", null, "33", "0", null, this);
            obj.set_taborder("3");
            obj.set_text("한촌-강남점 사업장");
            obj.set_cssclass("sta_RF_WelcomeArea");
            this.addChild(obj.name, obj);

            obj = new Static("staName", "absolute", "89", "98", null, "33", "0", null, this);
            obj.set_taborder("4");
            obj.set_text("홍길동님");
            obj.set_cssclass("sta_RF_WelcomeName");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu02", "absolute", "0", "227", null, "71", "0", null, this);
            obj.set_taborder("5");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu04", "absolute", "0", "369", null, "71", "0", null, this);
            obj.set_taborder("6");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu03", "absolute", "0", "298", null, "71", "0", null, this);
            obj.set_taborder("7");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu08", "absolute", "0", "653", null, "71", "0", null, this);
            obj.set_taborder("8");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu07", "absolute", "0", "582", null, "71", "0", null, this);
            obj.set_taborder("9");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu06", "absolute", "0", "511", null, "71", "0", null, this);
            obj.set_taborder("10");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnRMenu05", "absolute", "0", "440", null, "71", "0", null, this);
            obj.set_taborder("11");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnSetting", "absolute", null, null, "74", "74", "20", "20", this);
            obj.set_taborder("14");
            obj.set_cssclass("btn_RF_Setting");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 330, 923, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameLogin");
            		p.set_titletext("사이드메뉴");
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
            this._addPreloadList("data", "", "ds_list");
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.registerScript("CmmnFrameRightMenu.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 오른쪽 메뉴
        // [프로그램]		CmmnFrameRightMenu.xfdl
        // [설명]
        // 		프로젝트 실행 메인 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/

        
        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        this.CmmnFrameRightMenu_oninit = function(obj,e)
        {
        //	this.fn_init();	// cssclass 셋팅이 oninit에서만 되어서 oninit을 추가함
        }

        this.CmmnFrameRightMenu_onload = function(obj,e)
        {
        	//application.goMain.gfn_POP_resize(this);
        	//this.fn_init();
        }

        // 초기 셋팅
        this.fn_init = function ()
        {
        	// 로그인 정보 셋팅
        	this.staDept.set_text(application.g_UpjangNm);
        	this.staName.set_text(application.g_Name+"님");
        	
        	// 메뉴 dataset 복사
        	this.ds_rMenu.clearData();
        	this.ds_rMenu.copyData(application.gds_menu, true);
        	this.ds_rMenu.filter("levels == '1' && callParam == 'Y'");
        	//trace("ds_rMenu >>>> " +this.ds_rMenu.saveXML("ds_rMenu", "V"));
        //	trace(this.ds_rMenu.saveXML("ds_rMenu", "V"));
        	this.fn_RMenuSetting();
        }

        // Right 메뉴 셋팅
        this.fn_RMenuSetting = function ()
        {
        	// 필요한 갯수만큼 보이기
        	var objBtn;
        	var nRow = this.ds_rMenu.rowcount;
        	var ii;
        	var i;
        	
        	//리셋
        	for (ii = 0; ii < 8; ii++)
        	{		
        		objBtn = this.components["btnRMenu"+application.goMain.gfn_LPad((ii+1).toString(), "0", 2)];
        		objBtn.set_visible(false);
        	}	
        	
        	//사이드메뉴 셋팅
        	for (i = 0; i < nRow; i++)
        	{
        		objBtn = this.components["btnRMenu"+application.goMain.gfn_LPad((i+1).toString(), "0", 2)];
        		objBtn.set_visible(true);
        		// 버튼의 cssclass 셋팅
        		
        		switch (this.ds_rMenu.getColumn(i, "menuId"))
        		{
        			// 추가발주, 재고등록, 클레임신청, 게시판, E-FOODIST, 상품발주, 발주내역조회, 클레임신청현황
        			case "1787" :	// 추가발주
        				objBtn.set_cssclass("btn_RF_Menu01");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1796" :	// 구매신청현황
        				objBtn.set_cssclass("btn_RF_Menu02");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1814" :	//  클레임신청
        				objBtn.set_cssclass("btn_RF_Menu03");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1819" :	// 게시판
        			case "3244" :	// 게시판
        				objBtn.set_cssclass("btn_RF_Menu04");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1803" : // E-FOODIST
        				objBtn.set_cssclass("btn_RF_Menu05");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1797" :	// 상품발주
        				objBtn.set_cssclass("btn_RF_Menu06");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1798" :	// 발주내역조회
        				objBtn.set_cssclass("btn_RF_Menu07");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        			case "1815" :	// 클레임신청현황
        				objBtn.set_cssclass("btn_RF_Menu08");
        				objBtn.set_text(this.ds_rMenu.getColumn(i, "menuName"));
        				break;
        		}
        	}
        }

        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        // Right 메뉴 버튼 클릭 이벤트
        this.btnRMenu_onclick = function(obj,e)
        {
        	var nRow = parseInt(application.goMain.gfn_Right(obj.id, 2))-1;
        	
        	// action 실행
        	application.gv_menuId = this.ds_rMenu.getColumn(nRow, "menuId");
        	application.gv_formUrl = this.ds_rMenu.getColumn(nRow, "prgPath");
        	application.gv_menuName = this.ds_rMenu.getColumn(nRow, "menuName");
        	application.gv_progrmId = this.ds_rMenu.getColumn(nRow, "prgId");

        	application.goMain.gfn_POP_close(this , "");
        }

        // Setting 버튼 클릭 이벤트
        this.btnSetting_onclick = function(obj,e)
        {
        	var nRow = parseInt(application.goMain.gfn_Right(obj.id, 2))-1;
        	
        	// action 실행
        	application.gv_menuId = this.ds_rMenu.getColumn(nRow, "menuId");
        	application.gv_formUrl = this.ds_rMenu.getColumn(nRow, "prgPath");
        	application.gv_menuName = this.ds_rMenu.getColumn(nRow, "menuName");

        	application.goMain.gfn_POP_close(this , "Setting");
        }

        

        this.staDept_onclick = function(obj,e) {
        	if ( application.g_userId == "Z1855902" ) {
        		if( !this.btnRMenu01.cssclass || this.btnRMenu01.cssclass == null ) {
        			this.btnRMenu01.set_cssclass("btn_RF_Menu01");
        		} else {
        			this.btnRMenu01.set_cssclass("");
        		}
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameRightMenu_onload, this);
            this.addEventHandler("oninit", this.CmmnFrameRightMenu_oninit, this);
            this.btnRMenu01.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.staDept.addEventHandler("onclick", this.staDept_onclick, this);
            this.btnRMenu02.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu04.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu03.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu08.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu07.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu06.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnRMenu05.addEventHandler("onclick", this.btnRMenu_onclick, this);
            this.btnSetting.addEventHandler("onclick", this.btnSetting_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameRightMenu.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
