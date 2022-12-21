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
                this.set_name("MenuTableInquiry");
                this.set_titletext("식단표");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_cboHall", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"HALL_CD\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CYCLE\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"HALL_CD\">001</Col><Col id=\"HALL_NAME\">상식1</Col></Row><Row><Col id=\"HALL_CD\">002</Col><Col id=\"HALL_NAME\">상식선택식</Col></Row><Row><Col id=\"HALL_CD\">003</Col><Col id=\"HALL_NAME\">연식</Col></Row><Row><Col id=\"HALL_CD\">004</Col><Col id=\"HALL_NAME\">산모식</Col></Row><Row><Col id=\"HALL_CD\">005</Col><Col id=\"HALL_NAME\">소아식</Col></Row><Row><Col id=\"HALL_CD\">006</Col><Col id=\"HALL_NAME\">유아식</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_bodyList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_CD\" type=\"STRING\" size=\"256\"/><Column id=\"MEAL\" type=\"STRING\" size=\"256\"/><Column id=\"MEAL_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"RECIPE_INFO\" type=\"STRING\" size=\"256\"/><Column id=\"RECIPE_CD\" type=\"STRING\" size=\"256\"/><Column id=\"RECIPE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"RECIPE_CAL\" type=\"BIGDECIMAL\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condValid", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANGNM\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_CD\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_NM\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"START_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"EMP_NO\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER\" type=\"STRING\" size=\"256\"/><Column id=\"MEAL\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"UPJANG\">title:업장,required:true</Col><Col id=\"HALL_CD\">title:식당,required:true</Col><Col id=\"START_DATE\">title:주기식단등록월,required:true</Col><Col id=\"END_DATE\">title:주기식단등록월,required:true</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cboMeal", this);
            obj._setContents("<ColumnInfo><Column id=\"MEAL\" size=\"256\" type=\"STRING\"/><Column id=\"MEAL_NAME\" size=\"256\" type=\"STRING\"/></ColumnInfo><Rows><Row><Col id=\"MEAL\"/><Col id=\"MEAL_NAME\"/></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_menuList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MEAL\" type=\"STRING\" size=\"256\"/><Column id=\"MEAL_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER_NAME\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANGNM\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_CD\" type=\"STRING\" size=\"256\"/><Column id=\"HALL_NM\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"START_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"EMP_NO\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER\" type=\"STRING\" size=\"256\"/><Column id=\"MEAL\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_headList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"FDAY\" type=\"STRING\" size=\"256\"/><Column id=\"WE\" type=\"STRING\" size=\"256\"/><Column id=\"WE_COLOR\" type=\"STRING\" size=\"256\"/><Column id=\"WCD\" type=\"STRING\" size=\"256\"/><Column id=\"WNM\" type=\"STRING\" size=\"256\"/><Column id=\"WIMG\" type=\"STRING\" size=\"256\"/><Column id=\"REM\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cboCorner", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"CORNER\" type=\"STRING\" size=\"256\"/><Column id=\"CORNER_NAME\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "233", "540", "10", null, null, this);
            obj.set_taborder("19");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "279", "10", "479", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "243", null, null, "10", "0", this);
            obj.set_taborder("23");
            obj.set_scrollbars("autoboth");
            obj.set_binddataset("ds_menuList");
            obj.set_autofittype("none");
            obj.set_scrollpixel("all");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_selecttype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"0\" band=\"left\"/><Column size=\"57\" band=\"left\"/><Column size=\"62\" band=\"left\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"200\"/></Columns><Rows><Row size=\"45\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"끼니\"/><Cell col=\"2\" text=\"코너\"/><Cell col=\"3\" text=\"월\"/><Cell col=\"4\" text=\"화\"/><Cell col=\"5\" text=\"수\"/><Cell col=\"6\" text=\"목\"/><Cell col=\"7\" text=\"금\"/><Cell col=\"8\" text=\"토\"/><Cell col=\"9\" text=\"일\"/></Band><Band id=\"body\"><Cell celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;'summary&quot;:&quot;none&quot;\" style=\"align:left middle;padding:0 5 0 5;\" text=\"bind:outletBgnNm\" wordwrap=\"none\" suppress=\"1\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"background:#fffdecff;background2:#fffdecff;\" text=\"bind:MEAL_NAME\" suppress=\"1\" suppressalign=\"middle\"/><Cell col=\"2\" style=\"background:#e1e6f6ff;background2:#e1e6f6ff;\" text=\"bind:CORNER_NAME\" suppress=\"2\" suppressalign=\"middle\"/><Cell col=\"3\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\"/><Cell col=\"4\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/><Cell col=\"5\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/><Cell col=\"6\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/><Cell col=\"7\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/><Cell col=\"8\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/><Cell col=\"9\" edittype=\"none\" style=\"line:1 dotted #c3c3c3ff ;\" wordwrap=\"char\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("35");
            obj.set_text("팀명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_tm", "absolute", "120", "8", null, "47", "10", null, this);
            obj.set_taborder("36");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_tm", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("37");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("39");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "120", "66", null, "47", "10", null, this);
            obj.set_taborder("40");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("41");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("42");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "335", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("44");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtTo", "absolute", "335", "124", "195", "47", null, null, this);
            obj.set_taborder("43");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "120", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("46");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtFrom", "absolute", "120", "124", "195", "47", null, null, this);
            obj.set_taborder("45");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "1", "118", "135", "59", null, null, this);
            obj.set_taborder("47");
            obj.set_text("제공일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static34", "absolute", "319", "124", "15", "47", null, null, this);
            obj.set_taborder("48");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "0", "176", null, "59", "0", null, this);
            obj.set_taborder("49");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_hall", "absolute", "120", "182", null, "47", "116", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("50");
            obj.set_innerdataset("@ds_cboHall");
            obj.set_codecolumn("HALL_CD");
            obj.set_datacolumn("HALL_NAME");
            obj.set_visible("true");

            obj = new Button("btn_search", "absolute", null, "182", "100", "47", "10", null, this);
            obj.set_taborder("7");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "1", "176", "135", "59", null, null, this);
            obj.set_taborder("51");
            obj.set_text("식당명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("식단표");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("MenuTableInquiry.xfdl", "lib::lib_Com.xjs");
        this.registerScript("MenuTableInquiry.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		식단표
        // [부시스템명]	식단표 - 조회
        // [설명]
        // 		식단표 검색.
        // [작성자명] 		강대성
        // [작성일자]		2015.11.24
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.11.17 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow = undefined;
        this.tmCd = undefined;
        this.upjang = undefined;
        this.cboHall = undefined;

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
        this.form_onload = function(obj,e)
        {
        	//초기화
        	this.fsp_init();	
        	
        	//필수
        	this.fn_init();
        }

        this.fn_init = function ()
        {
        	// 조회조건 초기화
        	this.ds_cond.clearData();
        	this.ds_cond.addRow();
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_tm", "this.btn_tm");
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	//날짜 세팅(해당월의 1일 ~ 현재일) 
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);
        	this.cal_dtTo.set_value(this.preDate);
        			
        	//팀 및 업장 세팅
        	this.edt_tm.set_value(application.g_Tm_Nm);
        	this.edt_upjang.set_value(application.g_UpjangNm);
        	this.tmCd = application.g_Tm_Cd;
        	this.upjang = application.g_Upjang;	
        	
        	//데이터셋에 담는다
        	this.ds_cond.setColumn(0,"START_DATE",this.preDate);
        	this.ds_cond.setColumn(0,"END_DATE",this.preDate);
        	this.ds_cond.setColumn(0,"UPJANG",this.upjang);
        	
        	// 식당정보 조회
        	this.fn_hallSearch();
        	
        }

        // 화면 초기화
        this.fn_initData = function () {

        	// 그리드 데이터 초기화
        	this.ds_menuList.clearData();
        	this.ds_bodyList.clearData();
        	this.ds_headList.clearData();
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(To)
        this.sta_dtTo_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtTo.value;
        	
        	application.goMain.gfn_POP_create("PopCalTo", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // 식당명 팝업창 호출
        this.cbo_hall_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_cboHall;
        	arg[1] = "식당명";
        	arg[2] = "";
        	arg[3] = "HALL_NAME";
        	application.goMain.gfn_POP_create("cboHall", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        

        /** 
         * 팀 검색 팝업 호출
         */
        this.edt_dept_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_tm.value;
        	
        	application.goMain.gfn_POP_create("tmNm", "M_MSM::DeptSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(this.fn_masterRole())
        	{
        		arg[4] = application.g_RoleSetId1;
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2002') AND A.TM_CD LIKE '%' || '" + this.gfn_Nvl(this.tmCd ,"") + "' || '%'";	
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}
        	else
        	{
        		arg[4] = application.g_RoleSetId2;
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		
        		if(application.g_useTmCd == "Y")
        		{
        			arg[7] = application.g_Tm_Cd;
        		}
        		
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = application.g_UpjangGubun;
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	//필수항목 
        	if (this.fn_searchChk()) return;	
        	
        	// 그리드 데이터 초기화
        	this.ds_menuList.clearData();
        	this.ds_bodyList.clearData();
        	this.ds_headList.clearData();
        	
        	this.ds_cond.setColumn(0,"HALL_CD",this.ds_cboHall.getColumn(this.cboHall, "HALL_CD"));

        	this.fsp_clear();
        	this.fsp_addSearch("fs/fsm:FSM90030E_S001", false);  // 헤더 정보
        	this.fsp_callService(this, "", "", "ds_in=ds_cond ds_input=ds_cond", "ds_headList=DS_head" , "", "fn_callbackSearch");	  	
        	
        }

        this.fn_searchBody = function()
        {
        	this.ds_cond.setColumn(0,"HALL_CD",this.ds_cboHall.getColumn(this.cboHall, "HALL_CD"));

        	this.fsp_clear();
        	this.fsp_addSearch("fs/fsm:FSM00330R_S001", false);  // 식단 정보
        	this.fsp_callService(this, "", "", "ds_in=ds_cond ds_input=ds_cond", "ds_bodyList=ds_list" , "", "fn_callbackSearchBody");	  	
        	
        }

        /*******************************************************************************
        * 기      능   :  식당정보 조회
        * 설      명   :  식당정보 조회
        ********************************************************************************/
        this.fn_hallSearch = function ()
        {
        	// 업장이 선택되어 있을 경우에만 조회한다.
        	if(this.gfn_isNull(this.ds_cond.getColumn(0, "UPJANG"))) return;

        	// 기존 데이터 초기화
        	this.fn_initData();

        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fs/fsc:FSA_HALL_MST_S001", false);
        	// 서버 호출 
        	this.fsp_callService(this, "", "", "", "ds_cboHall=gds_Csqlout", "UPJANG=" + nexacro.wrapQuote(this.ds_cond.getColumn(0, "UPJANG")), "fn_callbackHallSearch");		// 서비스 호출 
        	
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if ( this.gfn_isNull(this.edt_upjang.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "사업장을 입력해주세요.", "OK", true, this);
        		return true;
        	}	
        	
        	if ( this.gfn_isNull(this.cal_dtFrom.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(From)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}	
        	
        	if ( this.gfn_isNull(this.cal_dtTo.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(To)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}	
        	
        	return false;
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callbackSearch = function (errCode,errMsg) 
        {
        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "서비스 오류:시스템 관리자에게 문의하십시오!", "OK", true, this);
        		return;
        	}
        	
        	// body조회
        	this.fn_searchBody();
        	
        }

        this.fn_callbackSearchBody = function (errCode,errMsg) 
        {
        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "서비스 오류:시스템 관리자에게 문의하십시오!", "OK", true, this);
        		return;
        	}
        	
        	// 그리드 데이터 세팅
        	this.fn_setMenuGridData(this.grd_list, this.ds_menuList, this.ds_headList, this.ds_bodyList);
        	
        }

        this.fn_callbackHallSearch = function (errCode,errMsg) 
        {
        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "서비스 오류:시스템 관리자에게 문의하십시오!", "OK", true, this);
        		return;
        	}
        	this.cbo_hall.set_index(0);

        	// 창고코드 셋팅
        	this.ds_cond.setColumn(0, "SUBINV_CODE", this.ds_cboHall.getColumn(0, "SUBINV_CODE"));	
        }
         
        /*----------------------------------------------------------------------------------------------
         * 함ㅡ수ㅡ명 : fn_setMenuGridData(grdObj, dsGrdObj, dsHeadObj, dsBodyObj)
         * 기ㅡㅡㅡ능 : 그리드 데이터 세팅(열량미표시)
          *---------------------------------------------------------------------------------------------*/ 
        this.fn_setMenuGridData = function (grdObj,dsGrdObj,dsHeadObj,dsBodyObj)
        {
        	dsGrdObj.set_enableevent(false);
        	var nRow, nCol;
        	dsGrdObj.set_keystring("S:+MEAL+CORNER+RECIPE_INFO");
        	dsGrdObj.clear();
        	dsGrdObj.addColumn("KEY"                 , "STRING");  // 키
        	dsGrdObj.addColumn("MEAL"                , "STRING");  // 끼니
        	dsGrdObj.addColumn("MEAL_NAME"           , "STRING");  // 끼니명
        	dsGrdObj.addColumn("CORNER"              , "STRING");  // 코너
        	dsGrdObj.addColumn("CORNER_NAME"         , "STRING");  // 코너명
        	dsGrdObj.addColumn("RECIPE_INFO"         , "STRING");  // 레시피순번
        	
        	
        	var sKey = "";
        	var nRow = 0;
        	
        	for(var i=0; i<dsBodyObj.getRowCount(); i++)
        	{
        		nRow = dsGrdObj.findRow("KEY", dsBodyObj.getColumn(i, "MEAL") + dsBodyObj.getColumn(i, "CORNER") + dsBodyObj.getColumn(i, "RECIPE_INFO"));
        		// 키가 존재하지 않을 경우 행 추가 후 세팅
        		if(nRow == -1)
        		{
        			nRow = dsGrdObj.addRow();
        			dsGrdObj.setColumn(nRow, "KEY"          , dsBodyObj.getColumn(i, "MEAL") + dsBodyObj.getColumn(i, "CORNER") + dsBodyObj.getColumn(i, "RECIPE_INFO"));			// 끼니코드 + 코너코드 + 레시피순번
        			dsGrdObj.setColumn(nRow, "MEAL"         , dsBodyObj.getColumn(i, "MEAL"));
        			dsGrdObj.setColumn(nRow, "MEAL_NAME"    , dsBodyObj.getColumn(i, "MEAL_NAME"));
        			dsGrdObj.setColumn(nRow, "CORNER"       , dsBodyObj.getColumn(i, "CORNER"));
        			dsGrdObj.setColumn(nRow, "CORNER_NAME"  , dsBodyObj.getColumn(i, "CORNER_NAME"));
        			dsGrdObj.setColumn(nRow, "RECIPE_INFO"  , dsBodyObj.getColumn(i, "RECIPE_INFO"));
        		}
        	}
        	
        	dsGrdObj.set_keystring("S:+MENU_DATE+MEAL+CORNER+RECIPE_INFO");
        	
        	sKey = "";
        	for (var i=0; i<dsBodyObj.rowcount; i++) 
        	{
        		sKey = dsBodyObj.getColumn(i, "MENU_DATE");
        		dsGrdObj.addColumn("RECIPE_NAME"  + sKey, "STRING");	
        		
        		var nFindRow = dsGrdObj.findRowExpr("MEAL=='" + dsBodyObj.getColumn(i, "MEAL") + "' && CORNER=='" + dsBodyObj.getColumn(i, "CORNER") + "' && RECIPE_INFO=='" + dsBodyObj.getColumn(i, "RECIPE_INFO") + "'");
        		if (nFindRow > -1) 
        		{
        			dsGrdObj.setColumn(nFindRow, "RECIPE_NAME"  + sKey, this.gfn_Trim(dsBodyObj.getColumn(i, "RECIPE_NAME")));
        		}
        	}	
        	
        	// 그리드 초기화
        	for (var i=grdObj.getFormatColCount() - 1; i > 2; i--)
        	{	
        		grdObj.deleteContentsCol("body", i, false);
        	}
        	
        	// TOP, RIGHT, BOTTEM, LEFT
        	var sProp1 = "0 none #c3c3c3ff, 1 dotted #c3c3c3ff, 0 none  #c3c3c3ff, 1 solid  #c3c3c3ff";  // 메뉴 body line
        	var sProp2 = "0 none #c3c3c3ff, 1 dotted #c3c3c3ff, 1 solid #c3c3c3ff, 0 none   #c3c3c3ff";  // 메뉴 소계 line
        	var sProp3 = "0 none #c3c3c3ff, 1 solid  #c3c3c3ff, 0 none  #c3c3c3ff, 1 dotted #c3c3c3ff";  // 원가 body line
        	var sProp4 = "0 none #c3c3c3ff, 1 solid  #c3c3c3ff, 1 solid #c3c3c3ff, 1 dotted #c3c3c3ff";  // 원가 소계 line
        	
        	var sColId;
        	var sDay;
        	var sMenuDate;
        	var sCorner;
        	
        	for (var i=0, nCol=-1; i < dsGrdObj.colcount; i++)
        	{		
        		sColId = dsGrdObj.getColID(i);
        		
        		if(sColId.indexOf("RECIPE_NAME") < 0) continue;
        		
        		if (sColId.substr(0, 11) == "RECIPE_NAME")
        		{
        			sMenuDate = sColId.replace("RECIPE_NAME", "");
        			nCol = grdObj.appendContentsCol();
        			
        			if (nCol > -1)
        			{
        				nRow = dsHeadObj.findRowExpr("FDAY==" + sMenuDate);
        				sDay = this.gfn_subStr(sMenuDate, 4, 2) + "/" + this.gfn_subStr(sMenuDate, 6, 2) + " (" + dsHeadObj.getColumn(nRow, "WE") + ")";
        				
        				grdObj.setFormatColProperty(nCol, "size", 200);
        				grdObj.setCellProperty("Head", nCol, "text", sDay);
        				grdObj.setCellProperty("Head", nCol, "color", "#" + dsHeadObj.lookup("FDAY", sMenuDate, "WE_COLOR"));
        				grdObj.setCellProperty("Head", this.fn_getColId(grdObj, nCol), "color", "#" + dsHeadObj.lookup("FDAY", sMenuDate, "WE_COLOR"));				
        				grdObj.setCellProperty("Body", nCol, "text", "bind:" + sColId);
        				grdObj.setCellProperty("Body", nCol, "wordwrap", "char");
        				grdObj.setCellProperty("Body", nCol, "align", "left");
        				grdObj.setCellProperty("Body", nCol, "padding", "2 5 2 5");
        				grdObj.setCellProperty("Body", nCol, "editautoselect", "true");
        				grdObj.setCellProperty("Body", nCol, "line", "1 solid #c3c3c3ff ");
        				//grdObj.setCellProperty("Body", nCol, "line", "EXPR( MEAL_NAME == comp.parent.ds_menulist.getColumn(currow+1, 'MEAL_NAME')?'" + sProp1 + "':(CORNER_NAME == comp.parent.ds_menulist.getColumn(currow+1, 'CORNER_NAME')?'" + sProp1 + "':'" + sProp2 + "'))");
        				
        			}
        		} 
        	}	
        	
        	dsGrdObj.set_rowposition(-1);
        	dsGrdObj.set_enableevent(true);
        }

        /*----------------------------------------------------------------------------------------------
         * 함ㅡ수ㅡ명 : fn_getColId(objGrid, nBodyColIdx)
         * 기ㅡㅡㅡ능 : 컬럼ID 세팅(열량미표시)
         *---------------------------------------------------------------------------------------------*/ 
        this.fn_getColId = function (objGrid,nBodyColIdx)
        {
        	var arrCellIdx = [];
        	
        	for (var i=0; i<objGrid.getCellCount("Head"); i++) {
        		var nHeadColIdx = objGrid.getCellProperty("Head", i, "col");
        		if (nBodyColIdx == nHeadColIdx) {
        			arrCellIdx[arrCellIdx.length] = i;
        		}
        	}	
        	return arrCellIdx[arrCellIdx.length-1];	
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
        		case "tmNm":
        			this.edt_tm.set_value(rtn[1]);
        			this.tmCd = rtn[0];
        			break;
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];	
        			this.ds_cond.setColumn(0,"UPJANG",rtn[0]);
        					
        			this.fn_hallSearch();
        					
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			this.ds_cond.setColumn(0,"START_DATE",rtn);
        			break;
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
        			this.ds_cond.setColumn(0,"END_DATE",rtn);
        			break;
        		case "cboHall":
        			this.cbo_hall.set_index(rtn);
        			this.cboHall = rtn;
        			break;	
        	}
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        }

        this.grd_list_onslide = function(obj,e)
        {
        	
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	}
        	else if (e.yaccvalue < 0)
        	{	
        		if (this.ds_menuList.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        		}		
        	}
        }

        this.grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		this.parent.btnGoTopDiv.set_left(420);
        		this.parent.btnGoTopDiv.set_right(65);
        		this.parent.btnGoTopDiv.set_bottom(10);		
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }

        this.edt_tm_ontouchend = function(obj,e)
        {
        	this.edt_tm.set_value("");
        	this.tmCd = "";
        }

        this.grd_list_onrbuttondown = function(obj,e)
        {
        	var nRow = this.ds_menuList.rowposition;
        	if(nRow < 0) return;

        	var nCell = this.grd_list.getCellPos();
        	if (nCell < 1) { return false; }
        	
        	system.clearClipboard();
        	
        	var sColId = this.grd_list.getCellProperty("body", nCell, "text").replace("bind:", "");
        	var sMeal = this.ds_menuList.getColumn(nRow, "MEAL");
        	var sCorner = this.ds_menuList.getColumn(nRow, "CORNER");

        	this.ds_menuList.filter("MEAL=='" + sMeal + "' && CORNER=='" + sCorner + "'");
        	var sMenuText = "";
        	for(var i=0; i<this.ds_menuList.getRowCount(); i++)
        	{
        		if(this.gfn_isNull(this.ds_menuList.getColumn(i, sColId))) 
        		{
        			if(i < this.ds_menuList.getRowCount() - 1)
        			{
        				sMenuText += "\r\n";
        			}
        			continue;
        		}
        	
        		sMenuText += this.ds_menuList.getColumn(i, sColId);
        		if(i < this.ds_menuList.getRowCount() - 1)
        		{
        			sMenuText += "\r\n";
        		}
        	}
        	this.ds_menuList.filter("");
        	system.setClipboard("CF_TEXT", sMenuText);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("ondropdown", this.grd_list_ondropdown, this);
            this.grd_list.addEventHandler("onrbuttondown", this.grd_list_onrbuttondown, this);
            this.edt_tm.addEventHandler("ontouchend", this.edt_tm_ontouchend, this);
            this.btn_tm.addEventHandler("onclick", this.edt_dept_onclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.cbo_hall.addEventHandler("ondropdown", this.cbo_hall_ondropdown, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);

        };

        this.loadIncludeScript("MenuTableInquiry.xfdl", true);

       
    };
}
)();
