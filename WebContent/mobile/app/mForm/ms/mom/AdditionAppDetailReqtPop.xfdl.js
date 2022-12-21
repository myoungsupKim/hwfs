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
                this.set_name("AdditionAppDetailReqtPop");
                this.set_titletext("추가발주승인상세등록팝업");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,376);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("false");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"checked\" type=\"STRING\" size=\"256\"/><Column id=\"reqQty\" type=\"STRING\" size=\"256\"/><Column id=\"poId\" type=\"STRING\" size=\"256\"/><Column id=\"poNum\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_m", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_s1", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_s2", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_s3", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_s4", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_reson_s5", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_check", this);
            obj._setContents("");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_check_input", this);
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" size=\"256\" type=\"STRING\"/><Column id=\"UPJANG_NM\" size=\"256\" type=\"STRING\"/><Column id=\"FROM_DT\" size=\"256\" type=\"STRING\"/><Column id=\"TO_DT\" size=\"256\" type=\"STRING\"/><Column id=\"APRV_YN\" size=\"256\" type=\"STRING\"/></ColumnInfo><Rows><Row><Col id=\"APRV_YN\"/><Col id=\"FROM_DT\"/><Col id=\"TO_DT\"/><Col id=\"UPJANG\"/><Col id=\"UPJANG_NM\"/></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "377", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("상세신청");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "366", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "588", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "336", "10", "100", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "29.23%", "80", null, "84", "26.92%", null, this);
            obj.set_taborder("12");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", null, "2", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "89", "20", "29", null, null, this);
            obj.set_taborder("19");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "10", "80", null, "59", "10", null, this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "10", "138", null, "59", "10", null, this);
            obj.set_taborder("22");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "10", "196", null, "59", "10", null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "10", "254", null, "59", "10", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Button("btn_insert", "absolute", "445", "319", "65", "47", null, null, this);
            obj.set_taborder("32");
            obj.set_text("입력");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "10", "80", "182", "59", null, null, this);
            obj.set_taborder("34");
            obj.set_text("신청시작일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "10", "139", "169", "59", null, null, this);
            obj.set_taborder("36");
            obj.set_text("신청종료일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "10", "196", "169", "59", null, null, this);
            obj.set_taborder("37");
            obj.set_text("사유");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_startDate", "absolute", "196", "86", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("44");
            obj.set_autoselect("true");
            obj.set_dateformat("yyyy-MM-dd");
            obj.style.set_padding("0 10 0 0");
            obj.set_enable("true");

            obj = new Combo("cbo_gubunMaster", "absolute", "196", "202", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("45");
            obj.set_innerdataset("@ds_reson_m");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_displaynulltext("선택");

            obj = new Combo("cbo_gubunSub", "absolute", "196", "260", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("46");
            obj.set_innerdataset("@ds_reson_s5");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_enable("false");

            obj = new Calendar("cal_endDate", "absolute", "196", "144", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("48");
            obj.set_autoselect("true");
            obj.set_dateformat("yyyy-MM-dd");
            obj.style.set_padding("0 10 0 0");

            obj = new Static("Static15", "absolute", "10", "254", "198", "59", null, null, this);
            obj.set_taborder("49");
            obj.set_text("상세사유");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_startDate", "absolute", "196", "86", "314", "47", null, null, this);
            obj.set_taborder("50");
            obj.set_enable("true");
            this.addChild(obj.name, obj);

            obj = new Static("sta_endDate", "absolute", "196", "144", "314", "47", null, null, this);
            obj.set_taborder("51");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 376, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("추가발주승인상세등록팝업");
            		p.set_scrollbars("none");
            		p.set_enable("true");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("AdditionAppDetailReqtPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AdditionAppDetailReqtPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		클레임신청상세현황
        // [부시스템명]	클레임신청상세현황
        // [설명]		    클레임신청상세현황.
        // [작성자명] 		강대성
        // [작성일자]		2015.05.26
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.26 : 강대성 : 클레임신청상세현황 신규
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.dsGubun = this.ds_reson_s5;
        this.gubun = undefined; 
        this.upjang = undefined; 
        var strDataGroup = "U_svc";

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
        	//필수
        	this.fn_init();
        	
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.fsp_init();
        	
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	application.goMain.gfn_POP_resize(this);
        	
        	//추가구매승인사유 대분류
        	this.fn_common_code("FS0123", "", "", "");	
        	this.ds_reson_m.copyData(application.gds_common_code);
        	
        	//추가구매승인사유 소분류1
        	this.fn_common_code("FS0124", "", "1", "");	
        	this.ds_reson_s1.copyData(application.gds_common_code);
        	
        	//추가구매승인사유 소분류2
        	this.fn_common_code("FS0124", "", "2", "");	
        	this.ds_reson_s2.copyData(application.gds_common_code);
        	
        	//추가구매승인사유 소분류3
        	this.fn_common_code("FS0124", "", "3", "");	
        	this.ds_reson_s3.copyData(application.gds_common_code);
        	
        	//추가구매승인사유 소분류4
        	this.fn_common_code("FS0124", "", "4", "");	
        	this.ds_reson_s4.copyData(application.gds_common_code);
        	
        	if(!this.gfn_isNull(this.arg[0]))
        	{
        		if(this.arg[2] == "1")
        		{
        			this.dsGubun = this.ds_reson_s1;
        			this.ds_reson_s5.copyData(this.ds_reson_s1);
        			this.cbo_gubunSub.set_enable(true);
        		}
        		else if(this.arg[2] == "2")
        		{
        			this.dsGubun = this.ds_reson_s2;
        			this.ds_reson_s5.copyData(this.ds_reson_s2);
        			this.cbo_gubunSub.set_enable(true);
        		}
        		else if(this.arg[2] == "3")
        		{
        			this.dsGubun = this.ds_reson_s3;
        			this.ds_reson_s5.copyData(this.ds_reson_s3);
        			this.cbo_gubunSub.set_enable(true);
        		}
        		else if(this.arg[2] == "4")
        		{
        			this.dsGubun = this.ds_reson_s4;
        			this.ds_reson_s5.copyData(this.ds_reson_s4);
        			this.cbo_gubunSub.set_enable(true);
        		}
        		
        		this.cal_startDate.set_value(this.arg[0]);
        		this.cal_endDate.set_value(this.arg[1]);
        		this.cbo_gubunMaster.set_text(this.arg[3]);
        		this.cbo_gubunSub.set_text(this.arg[4]);
        				
        	}	
        	else
        	{
        		this.cbo_gubunSub.set_enable(false);
        	}
        	
        	this.upjang = this.arg[5];
        	
        	//row값이 입력일경우 시작 및 종료일 입력 가능하게
        	if(this.arg[6] == 2)
        	{
        		this.sta_startDate.set_enable(true);
        		this.sta_endDate.set_enable(true);
        		this.cal_startDate.set_enable(true);
        		this.cal_endDate.set_enable(true);
        	}
        	//row값이 입력이 아닐경우 시작 및 종료일 입력 불가능하게
        	else
        	{
        		this.sta_startDate.set_enable(false);
        		this.sta_endDate.set_enable(false);
        		this.cal_startDate.set_enable(false);
        		this.cal_endDate.set_enable(false);
        	}
        	
        }

        // 달력 클릭 시(구매신청시작일)
        this.sta_startDate_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_startDate.value;
        	
        	application.goMain.gfn_POP_create("startDate", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(구매신청종료일)
        this.sta_endDate_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_endDate.value;
        	
        	application.goMain.gfn_POP_create("endDate", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        //추가구매승인사유 대분류
        this.cbo_gubunMaster_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_reson_m;
        	arg[1] = "사유";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("gubunMaster", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //추가구매승인사유 소분류
        this.cbo_gubunSub_ondropdown = function(obj,e)
        {
        	if(this.gubun == "0")
        	{
        		this.ds_reson_s5.copyData(this.ds_reson_s1);
        	}
        	else if(this.gubun == "1")
        	{
        		this.ds_reson_s5.copyData(this.ds_reson_s2);
        	}
        	else if(this.gubun == "2")
        	{
        		this.ds_reson_s5.copyData(this.ds_reson_s4);
        	}
        	else if(this.gubun == "3")
        	{
        		this.ds_reson_s5.copyData(this.ds_reson_s3);
        	}
        	
        	var arg = new Array();
        	arg[0] = this.dsGubun;
        	arg[1] = "상세사유";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("gubunSub", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  중복체크
        * 설      명   :  중복체크
        ********************************************************************************/
        this.fn_CheckSearch = function()
        {
        	var nRow = 0;
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
            
            // 초기화
        	this.ds_check.clearData();
        	this.ds_check_input.clearData();
        	
        	nRow = this.ds_check_input.addRow();
        	
        	this.ds_check_input.setColumn(nRow,"UPJANG" , this.upjang); 
        	this.ds_check_input.setColumn(nRow,"FROM_DT", this.cal_startDate.value);
        	this.ds_check_input.setColumn(nRow,"TO_DT"  , this.cal_endDate.value);
        	
        	sSvcID		= "CHK_SEARCH";
        	sUrl		= application.services[strDataGroup].url + "fs/fsa/FSA00090E_S002.jsp";
        	sInDs		= "ds_check_input=ds_check_input";
            sOutDs		= "ds_check=ds_check";
            sArg		= "";
            sCallFunc	= "fn_callback";
            
            this.jsp_transaction(this,sSvcID, sUrl ,sInDs ,sOutDs,sArg,sCallFunc,false,false,false);
        				
        }

        /*******************************************************************************
        * 기      능   :  입력 항목 체크
        * 설      명   :  입력 항목 체크
        ********************************************************************************/ 
        this.fn_insertChk = function()
        {
        	// 기간 유효성 체크
        	if (this.cal_startDate.value > this.cal_endDate.value){
        		application.goMain.gfn_Msg("OK", "알림", "시작일이 종료일보다 클 수 없습니다.", "OK", "OK");
        		return false;
        	}	
        	
        	// 기간 유효성 체크
        	if (this.gfn_AddDate(this.cal_startDate.value, 3) < this.cal_endDate.value){
        		application.goMain.gfn_Msg("OK", "알림", "시작일과 종료일간의 차이는 3일을 넘을 수 없습니다.", "OK", "OK");
        		return false;
        	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  입력버튼 클릭시
        * 설      명   :  입력버튼 클릭시
        ********************************************************************************/ 
        this.btn_insert_onclick = function(obj,e)
        {

        	if (this.gfn_isNull(this.cal_startDate.value)){
        		application.goMain.gfn_Msg("OK", "알림", "구매신청일(시작일)을 입력하세요.", "OK", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.cal_endDate.value)){
        		application.goMain.gfn_Msg("OK", "알림", "구매신청일(종료일)을 입력하세요.", "OK", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.cbo_gubunMaster.value)){
        		application.goMain.gfn_Msg("OK", "알림", "사유를 선택하세요.", "OK", "OK");
        		return;		
        	}
        	
        	if (this.gfn_isNull(this.cbo_gubunSub.value)){
        		application.goMain.gfn_Msg("OK", "알림", "상세사유를 선택하세요.", "OK", "OK");
        		return;		
        	}	
        	
        	// 기간 유효성 체크
        	if (this.cal_startDate.value > this.cal_endDate.value){
        		application.goMain.gfn_Msg("OK", "알림", "시작일이 종료일보다 클 수 없습니다.", "OK", "OK");
        		return;
        	}	
        	
        	// 기간 유효성 체크
        	if (this.gfn_AddDate(this.cal_startDate.value, 3) < this.cal_endDate.value){
        		application.goMain.gfn_Msg("OK", "알림", "시작일과 종료일간의 차이는 3일을 넘을 수 없습니다.", "OK", "OK");
        		return;
        	}
        	
        	var arg = new Array();
        	arg[0] = this.cal_startDate.value;    // 구매신청일(시작일)
        	arg[1] = this.cal_endDate.value;      // 구매신청일(종료일)	
        	arg[2] = this.cbo_gubunMaster.value;  // 사유	
        	arg[3] = this.cbo_gubunSub.value;     // 상세사유	
        	
        	application.goMain.gfn_POP_close(this, arg);
        	
        }

        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : JSP트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callback = function(nErrorCode,sErrorMag,sSvcID)
        {
        	// 에러일 경우
        	if(nErrorCode!=0){
        		application.goMain.gfn_Msg("EE", "알림", "서비스 오류:시스템 관리자에게 문의하십시오" + sErrorMag, "OK", "OK");
        		return;
        	}
        	
        	switch(sSvcID){		
        		
        		case "CHK_SEARCH" :
        			if(this.ds_check.getRowCount() > 0){
        				application.goMain.gfn_Msg("duplication", "알림", "중복된 신청내역이 있습니다.\n확인해주십시오.", "OK", true, this);
        				return;
        			}
        			break;		
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
        		case "startDate":
        			this.cal_startDate.set_value(rtn);
        			
        			if (!this.gfn_isNull(this.cal_endDate.value)){
        				
        				//필수항목 
        				if (!this.fn_insertChk()) return;
        				
        				// 중복체크(server)
        				this.fn_CheckSearch();
        			}
        			
        			break;
        		case "endDate":
        			this.cal_endDate.set_value(rtn);
        			
        			//필수항목 
        			if (!this.fn_insertChk()) return;
        				
        			// 중복체크(server)
        			this.fn_CheckSearch();
        			
        			break;	
        		case "gubunMaster":
        			this.cbo_gubunMaster.set_index(rtn);			
        			this.gubun = rtn;
        			this.cbo_gubunSub.set_text("");
        			if(rtn == 0)
        			{					
        				this.dsGubun = this.ds_reson_s1;
        				this.cbo_gubunSub.set_enable(true);
        			}
        			else if(rtn == 1)
        			{
        				this.dsGubun = this.ds_reson_s2;
        				this.cbo_gubunSub.set_enable(true);
        			}
        			else if(rtn == 2)
        			{
        				this.dsGubun = this.ds_reson_s4;
        				this.cbo_gubunSub.set_enable(true);
        			}
        			else if(rtn == 3)
        			{
        				this.dsGubun = this.ds_reson_s3;
        				this.cbo_gubunSub.set_enable(true);
        			}
        			
        			this.ds_reson_s5.clearData();
        			
        			break;	
        		case "gubunSub":
        			trace(this.ds_reson_s5.saveXML("this.ds_reson_s5 >>>", "V"));
        			this.cbo_gubunSub.set_index(rtn);			
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
        	
        	// 중복체크(중복건이 있을경우) 입력건 초기화시킴
        	if (id == "duplication")
        	{
        		this.cal_endDate.set_value("");
        	}	
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_check_input.addEventHandler("oncolumnchanged", this.ds_input_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.btn_insert.addEventHandler("onclick", this.btn_insert_onclick, this);
            this.cbo_gubunMaster.addEventHandler("ondropdown", this.cbo_gubunMaster_ondropdown, this);
            this.cbo_gubunSub.addEventHandler("ondropdown", this.cbo_gubunSub_ondropdown, this);
            this.sta_startDate.addEventHandler("onclick", this.sta_startDate_onclick, this);
            this.sta_endDate.addEventHandler("onclick", this.sta_endDate_onclick, this);

        };

        this.loadIncludeScript("AdditionAppDetailReqtPop.xfdl", true);

       
    };
}
)();
