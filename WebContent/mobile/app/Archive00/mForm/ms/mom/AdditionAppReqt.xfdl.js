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
                this.set_name("AdditionAppReqt");
                this.set_titletext("추가구매승인신청");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd", this);
            obj._setContents("<ColumnInfo><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"MU_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"TM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"TM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"APRV_10\" size=\"1\" type=\"STRING\"/><Column id=\"APRV_YN\" size=\"1\" type=\"STRING\"/><Column id=\"END_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"PR_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"REASON_CD\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REASON\" size=\"1000\" type=\"STRING\"/><Column id=\"START_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"UPJANG\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"UPJANGNM\" size=\"79\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_input", this);
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" size=\"256\" type=\"STRING\"/><Column id=\"UPJANG_NM\" size=\"256\" type=\"STRING\"/><Column id=\"FROM_DT\" size=\"256\" type=\"STRING\"/><Column id=\"TO_DT\" size=\"256\" type=\"STRING\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"TM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"APRV_YN\" size=\"256\" type=\"STRING\"/></ColumnInfo><Rows><Row><Col id=\"APRV_YN\"/><Col id=\"FROM_DT\"/><Col id=\"TO_DT\"/><Col id=\"UPJANG\"/><Col id=\"UPJANG_NM\"/></Row></Rows>");
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

            obj = new Dataset("ds_expt_upjang_list", this);
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

            obj = new Dataset("ds_del_list", this);
            obj._setContents("<ColumnInfo><Column id=\"APRV_10\" size=\"1\" type=\"STRING\"/><Column id=\"APRV_YN\" size=\"1\" type=\"STRING\"/><Column id=\"END_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"PR_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"REASON_CD\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REASON\" size=\"1000\" type=\"STRING\"/><Column id=\"START_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"UPJANG\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"UPJANGNM\" size=\"79\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_check_input", this);
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" size=\"256\" type=\"STRING\"/><Column id=\"UPJANG_NM\" size=\"256\" type=\"STRING\"/><Column id=\"FROM_DT\" size=\"256\" type=\"STRING\"/><Column id=\"TO_DT\" size=\"256\" type=\"STRING\"/><Column id=\"APRV_YN\" size=\"256\" type=\"STRING\"/></ColumnInfo><Rows><Row><Col id=\"APRV_YN\"/><Col id=\"FROM_DT\"/><Col id=\"TO_DT\"/><Col id=\"UPJANG\"/><Col id=\"UPJANG_NM\"/></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_check", this);
            obj._setContents("");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "59", null, "59", "0", null, this);
            obj.set_taborder("9");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "238", "65", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("10");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_editformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Button("btn_search", "absolute", "430", "65", "100", "47", null, null, this);
            obj.set_taborder("12");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "460", "144", "5", "19", null, null, this);
            obj.set_taborder("18");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "233", "72", "5", "29", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "175", null, null, "0", "0", this);
            obj.set_taborder("22");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_readonly("true");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"146\"/><Column size=\"76\"/><Column size=\"117\"/><Column size=\"132\"/><Column size=\"69\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"51\" band=\"head\"/><Row size=\"51\" band=\"head\"/><Row size=\"51\"/><Row size=\"51\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\"/><Cell col=\"3\" text=\"Column2\"/><Cell col=\"4\" text=\"Column3\"/><Cell row=\"1\" text=\"작성일\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" text=\"신청시작일\"/><Cell row=\"1\" col=\"3\" colspan=\"2\" text=\"신청종료일\"/><Cell row=\"2\" text=\"사유\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" text=\"상세사유\"/><Cell row=\"2\" col=\"4\" text=\"승인\"/></Band><Band id=\"body\"><Cell displaytype=\"date\" style=\"align:left bottom;padding:0 10 10 10;line:0 none #808080ff ;\" text=\"bind:PR_DATE\"/><Cell col=\"1\" colspan=\"2\" style=\"align:left bottom;padding:5 10 10 5;line:0 none #808080ff ;\" text=\"bind:START_DATE\" mask=\"expr:START_DATE == undefined?&quot;&quot;:&quot;####-##-##&quot;\" editdisplay=\"expr:APRV_YN==&quot;Y&quot; ?&quot;edit&quot;:&quot;display&quot;\" calendardisplay=\"edit\"/><Cell col=\"3\" colspan=\"2\" style=\"align:left bottom;padding:5 10 10 5;line:0 none #808080ff ;\" text=\"bind:END_DATE\" mask=\"expr:END_DATE == undefined?&quot;&quot;:&quot;####-##-##&quot;\" editdisplay=\"expr:APRV_YN==&quot;Y&quot; ?&quot;edit&quot;:&quot;display&quot;\"/><Cell row=\"1\" displaytype=\"combo\" style=\"align:left top;padding:10 10 5 10;line:0 solid #808080ff ;\" text=\"bind:REASON_CD\" wordwrap=\"none\" editdisplay=\"expr:APRV_YN==&quot;Y&quot; ?&quot;edit&quot;:&quot;display&quot;\" combodataset=\"ds_reson_m\" combocodecol=\"cd\" combodatacol=\"cdNm\" combodisplay=\"expr:APRV_YN==&quot;Y&quot; ?&quot;edit&quot;:&quot;display&quot;\"/><Cell row=\"1\" col=\"1\" colspan=\"3\" displaytype=\"combo\" style=\"align:left top;padding:10 10 5 5;line:0 solid #808080ff ;\" text=\"bind:PR_REASON\" wordwrap=\"none\" editdisplay=\"expr:APRV_YN==&quot;Y&quot; ?&quot;edit&quot;:&quot;display&quot;\" combodataset=\"expr:REASON_CD == &quot;1&quot; ? &quot;ds_reson_s1&quot; : REASON_CD == &quot;2&quot; ? &quot;ds_reson_s2&quot; :REASON_CD == &quot;3&quot; ? &quot;ds_reson_s3&quot; :REASON_CD == &quot;4&quot; ? &quot;ds_reson_s4&quot; : &quot;&quot;\" combocodecol=\"cd\" combodatacol=\"cdNm\" combodisplay=\"expr:APRV_YN==&quot;Y&quot; ? &quot;edit&quot; : &quot;display&quot;\"/><Cell row=\"1\" col=\"4\" displaytype=\"normal\" edittype=\"none\" style=\"align:center top;padding:10 10 5 5;line:0 solid #808080ff ;\" text=\"bind:APRV_YN\" wordwrap=\"char\" maskchar=\" \" editdisplay=\"edit\"/><Cell row=\"2\"/><Cell row=\"2\" col=\"1\"/><Cell row=\"2\" col=\"2\"/><Cell row=\"2\" col=\"3\"/><Cell row=\"2\" col=\"4\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("24");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("25");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "239", "89", "186", "47", null, null, this);
            obj.set_taborder("28");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "117", null, "59", "0", null, this);
            obj.set_taborder("30");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_delete", "absolute", null, "123", "65", "47", "96", null, this);
            obj.set_taborder("33");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "6", "65", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("35");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtFrom", "absolute", "7", "81", "186", "47", null, null, this);
            obj.set_taborder("34");
            this.addChild(obj.name, obj);

            obj = new Static("Static34", "absolute", "210", "66", "15", "47", null, null, this);
            obj.set_taborder("36");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_appYn", "absolute", null, "124", "153", "47", "379", null, this);
            obj.set_taborder("37");
            obj.set_text("승인포함");
            obj.set_value("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_addRow", "absolute", "450", "133", "37", "37", null, null, this);
            obj.set_taborder("38");
            obj.set_text("+");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("btn_delRow", "absolute", "493", "133", "37", "37", null, null, this);
            obj.set_taborder("39");
            obj.set_text("-");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save", "absolute", null, "123", "65", "47", "167", null, this);
            obj.set_taborder("40");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("추가구매승인신청");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("AdditionAppReqt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AdditionAppReqt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		발주관리
        // [부시스템명]	추가구매 승인신청
        // [설명]
        // 		추가구매 승인신청하기
        // [작성자명] 		강대성
        // [작성일자]		2015.09.15
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.09.15 : 강대성 : 화면 신규생성
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.firstDate = undefined;
        this.upjang = undefined;
        var mIndex = 0;
        var sIndex = 0;
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

        this.fn_init = function ()
        {
        	this.fsp_init();
        	
        	application.goMenu = this;	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("","this.btn_save");	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("","this.btn_delete");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	//추가구매승인예외 사업장코드
        	this.fn_common_code("FS0125", "", "", "");	
        	this.ds_expt_upjang_list.copyData(application.gds_common_code);
        	
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
        	
        	//현재일 세팅
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,6) + "01";
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);	
        	
        	//업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        		
        	this.ds_input.setColumn(0,"UPJANG"     ,application.g_Upjang);		 // 업장코드
        	this.ds_input.setColumn(0,"UPJANG_NM"  ,application.g_UpjangNm	);	 // 업장명
        	this.ds_input.setColumn(0,"FROM_DT"    ,this.firstDate);		     // 일자(from)
        	this.ds_input.setColumn(0,"TO_DT"      ,this.preDate);		         // 일자(to)
        		
        }

        /*==========================================================================
         * 사업장 검색 팝업 호출
        *========================================================================*/
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(this.fn_masterRole())
        	{
        		arg[4] = application.g_RoleSetId1;
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2002','2003')";
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

        // 그리드 cell클릭시
        this.grd_list_oncellclick = function(obj,e)
        {
        	//alert(e.cell);
        	var nRow = e.row;
        	
        	var gubun = this.ds_grd.getColumn(nRow, "APRV_YN")
        	if(gubun == "N")
        	{
        		var arg = new Array();
        		arg[0] = this.ds_grd.getColumn(nRow, "START_DATE");
        		arg[1] = this.ds_grd.getColumn(nRow, "END_DATE");	
        		arg[2] = this.ds_grd.getColumn(nRow, "REASON_CD");		
        		
        		//대분류(식수변동)
        		if(this.ds_grd.getColumn(nRow, "REASON_CD") == "1")
        		{
        			sIndex = this.ds_reson_s1.findRowExpr("cd=='" + this.ds_grd.getColumn(nRow, "PR_REASON") + "'");	
        			arg[3] = this.ds_reson_m.getColumn(0, "cdNm");		
        			arg[4] = this.ds_reson_s1.getColumn(sIndex, "cdNm");
        		}
        		//대분류(식단변경)
        		else if(this.ds_grd.getColumn(nRow, "REASON_CD") == "2")
        		{
        			sIndex = this.ds_reson_s2.findRowExpr("cd=='" + this.ds_grd.getColumn(nRow, "PR_REASON") + "'");
        			arg[3] = this.ds_reson_m.getColumn(1, "cdNm");			
        			arg[4] = this.ds_reson_s2.getColumn(sIndex, "cdNm");
        		}
        		//대분류(기타사유)
        		else if(this.ds_grd.getColumn(nRow, "REASON_CD") == "3")
        		{
        			sIndex = this.ds_reson_s3.findRowExpr("cd=='" + this.ds_grd.getColumn(nRow, "PR_REASON") + "'");	
        			arg[3] = this.ds_reson_m.getColumn(3, "cdNm");		
        			arg[4] = this.ds_reson_s3.getColumn(sIndex, "cdNm");
        		}
        		//대분류(모바일신청)
        		else if(this.ds_grd.getColumn(nRow, "REASON_CD") == "4")
        		{
        			sIndex = this.ds_reson_s4.findRowExpr("cd=='" + this.ds_grd.getColumn(nRow, "PR_REASON") + "'");
        			arg[3] = this.ds_reson_m.getColumn(2, "cdNm");			
        			arg[4] = this.ds_reson_s4.getColumn(sIndex, "cdNm");
        		}
        		
        		arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition, "UPJANG");  //업장코드를 넘긴다
        		arg[6] = this.ds_grd.getRowType(this.ds_grd.rowposition);           //row타입을 넘긴다
        		
        		application.goMain.gfn_POP_create("additionAppDetailReqtPop", "M_MOM::AdditionAppDetailReqtPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;
        	}
        	
        }

        /*-------------------------------------------------------------------------------------------------+
        >>  기   능:	그리드 추가버튼 클릭시 이벤트
        +-------------------------------------------------------------------------------------------------*/
        this.btn_addRow_onclick = function(obj,e)
        {
        	var nAddRow = 0;
        	if (this.gfn_Length(this.ds_input.getColumn(0,"UPJANG"))== 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "사업장을 입력하세요.", "OK", "OK");
        		return false;
        	}
        	
        	nAddRow = this.ds_grd.addRow();
        	this.ds_grd.setColumn(nAddRow,"UPJANG"	    ,this.ds_input.getColumn(0,"UPJANG"));
        	this.ds_grd.setColumn(nAddRow,"PR_DATE"	,this.preDate);
        	this.ds_grd.setColumn(nAddRow,"APRV_YN"	,"N");	
        }

        /*-------------------------------------------------------------------------------------------------+
        >>  기   능:	그리드row 삭제 버튼 클릭시 이벤트
        +-------------------------------------------------------------------------------------------------*/
        this.btn_delRow_onclick = function(obj,e)
        {
        	nRowType = this.ds_grd.getRowType(this.ds_grd.rowposition);
            if(nRowType == "2"){
        		this.ds_grd.deleteRow(this.ds_grd.rowposition);
        		return;
            }
        }

        /*******************************************************************************
        * 기      능   :  검색, 저장, 삭제
        * 설      명   :  검색, 저장, 삭제 버튼 터치시
        ********************************************************************************/
        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_search":
        			this.fn_GetUpdate();
        			break;
        		case "btn_save":
        			application.goMain.gfn_Msg("save", "저장", "추가구매승인 신청하시겠습니까?!", "YN", true, this);
        			break;
        		case "btn_delete":
        			application.goMain.gfn_Msg("delete", "삭제", "선택하신 데이터를 삭제 하시겠습니까?", "YN", true, this);
        			break;
        		default:
        			break;
        	}
        }

        this.fn_GetUpdate = function ()
        {
        	if(this.gfn_dsIsUpdated(this.ds_grd)==true)
        	{	
        		application.goMain.gfn_Msg("confirm01", "확인", "미저장 데이터가 있습니다.\n계속하시겠습니까?", "YN", true, this);	
        	}
        	else
        	{
        		this.fn_search();
        	}
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  검색
        ********************************************************************************/
        this.fn_search = function ()
        {
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	sSvcID		= "SEARCH";
        	sUrl		= application.services[strDataGroup].url + "fs/fsa/FSA00090E_S001.jsp";
        	sInDs		= "ds_input=ds_input";
        	sOutDs		= "ds_grd=ds_list";
        	sCallFunc	= "fn_callback";
        	
        	// 유효성 체크
        	if(!this.fn_validation(sSvcID)){return false;}
        	
        	// 초기화
        	this.ds_grd.clearData();
        	this.ds_input.setColumn(0,"APRV_YN",this.iif(this.chk_appYn.value==false,"N",""));
        	
        	this.jsp_transaction(this,sSvcID, sUrl ,sInDs ,sOutDs,sArg,sCallFunc,false,false,false);	
        	
        }

        /*******************************************************************************
        * 기      능   :  저장
        * 설      명   :  등록
        ********************************************************************************/
        this.fn_save = function()
        {
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
            
        	sSvcID		= "SAVE";
        	sUrl		= application.services[strDataGroup].url + "fs/fsa/FSA00090E_T001.jsp";
        	
        	sInDs		= "ds_list=ds_grd:U";
            sOutDs		= "";
            sArg		= "";
            sCallFunc	= "fn_callback";
            
            // 유효성 체크
            if(!this.fn_validation(sSvcID)){return false;}
        	
        	this.jsp_transaction(this,sSvcID, sUrl ,sInDs ,sOutDs,sArg,sCallFunc,false,false,false);
        				
        }

        /*******************************************************************************
        * 기      능   :  삭제
        * 설      명   :  삭제
        ********************************************************************************/
        this.fn_delete = function()
        {
        	var nRow = 0;
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
            
        	sSvcID		= "DELETE";
        	sUrl		= application.services[strDataGroup].url + "fs/fsa/FSA00090E_T002.jsp";
        	
        	sInDs		= "ds_del_list=ds_del_list:A";
            sOutDs		= "";
            sArg		= "";
            sCallFunc	= "fn_callback";
            
            // 유효성 체크
            if(!this.fn_validation(sSvcID)){return false;}
            
            this.ds_del_list.clearData();
        	nRow = this.ds_del_list.addRow();
        	this.ds_del_list.copyRow(nRow, this.ds_grd, this.ds_grd.rowposition);
        	
        	this.jsp_transaction(this,sSvcID, sUrl ,sInDs ,sOutDs,sArg,sCallFunc,false,false,false);
        				
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
        	
        	this.ds_check_input.setColumn(nRow,"UPJANG" , this.ds_grd.getColumn(this.ds_grd.rowposition, "UPJANG"));
        	this.ds_check_input.setColumn(nRow,"FROM_DT", this.ds_grd.getColumn(this.ds_grd.rowposition, "START_DATE"));
        	this.ds_check_input.setColumn(nRow,"TO_DT"  , this.ds_grd.getColumn(this.ds_grd.rowposition, "END_DATE"));
        	
        	sSvcID		= "CHK_SEARCH";
        	sUrl		= application.services[strDataGroup].url + "fs/fsa/FSA00090E_S002.jsp";
        	sInDs		= "ds_check_input=ds_check_input";
            sOutDs		= "ds_check=ds_check";
            sArg		= "";
            sCallFunc	= "fn_callback";
            
            this.jsp_transaction(this,sSvcID, sUrl ,sInDs ,sOutDs,sArg,sCallFunc,false,false,false);
        				
        }

        /*******************************************************************************
        * 기      능   :  조회유효성체크
        * 설      명   :  조회유효성체크
        ********************************************************************************/
        this.fn_validation = function(sSvcID)
        {
        	switch(sSvcID)
        	{
        		case "SEARCH" :
        			if (this.gfn_Length(this.ds_input.getColumn(0,"UPJANG"))== 0){
        				application.goMain.gfn_Msg("OK", "알림", "사업장을 입력하세요.", "OK", "OK");
        				return false;
        			}

        			if (this.gfn_Length(this.ds_input.getColumn(0,"FROM_DT"))== 0){
        				application.goMain.gfn_Msg("OK", "알림", "날짜를 입력하세요", "OK", "OK");
        				return false;
        			}

        			if (this.gfn_Length(this.ds_input.getColumn(0,"TO_DT"))== 0){
        				application.goMain.gfn_Msg("OK", "알림", "날짜를 입력하세요", "OK", "OK");
        				return false;
        			}

        			if (this.ds_input.getColumn(0,"FROM_DT") > this.ds_input.getColumn(0,"TO_DT")){
        				application.goMain.gfn_Msg("OK", "알림", "검색기간을 확인해 주십시오.", "OK", "OK");
        				return false;
        			}
        			break;
        			
        		case "SAVE" :
        			if(this.ds_grd.getRowCount()==0){
        				application.goMain.gfn_Msg("OK", "알림", "저장할 데이터가 없습니다.", "OK", "OK");
        				return;
        			}
        		
        			// 변경여부 확인
        			if(!this.gfn_dsIsUpdated(this.ds_grd)){
        				application.goMain.gfn_Msg("OK", "알림", "변경된 데이터가 없습니다.", "OK", "OK");
        				return;
        			}
        			
        			if(this.gfn_isNull(this.ds_grd.getColumn(this.ds_grd.rowposition,"START_DATE")))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "신청시작일을 입력하세요.", "OK", "OK");
        				return false;			
        			}
        			
        			if(this.gfn_isNull(this.ds_grd.getColumn(this.ds_grd.rowposition,"END_DATE")))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "신청종료일을 입력하세요.", "OK", "OK");
        				return false;			
        			}
        							
        			if(this.gfn_isNull(this.ds_grd.getColumn(this.ds_grd.rowposition,"REASON_CD")))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "사유를 선택하세요.", "OK", "OK");
        				return false;			
        			}	
        							
        			if(this.gfn_isNull(this.ds_grd.getColumn(this.ds_grd.rowposition,"PR_REASON")))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "상세사유를 선택하세요", "OK", "OK");
        				return false;			
        			}					

        			if (this.ds_grd.getColumn(this.ds_grd.rowposition,"FROM_DT") > this.ds_grd.getColumn(this.ds_grd.rowposition,"TO_DT")){
        				application.goMain.gfn_Msg("OK", "알림", "검색기간을 확인해 주십시오.", "OK", "OK");
        				return false;
        			}			
        			
        			break;
        		case "DELETE" :
        		
        			if(this.ds_grd.getRowCount()==0){
        				application.goMain.gfn_Msg("OK", "알림", "삭제할 데이터가 없습니다.", "OK", "OK");
        				return;
        			}

        			if (this.gfn_dsIsUpdated(this.ds_grd)){
        				application.goMain.gfn_Msg("OK", "알림", "변경된 데이터가 있습니다.\n 저장 후 삭제해십시오.", "OK", "OK");
        				return;
        			}

        			if (this.ds_grd.getColumn(this.ds_grd.rowposition,"APRV_YN") == "Y"){
        				application.goMain.gfn_Msg("OK", "알림", "승인된 데이터입니다.\n삭제할 수 없습니다.", "OK", "OK");
        				return;
        			}
        			
        			break;
        	}
        	
            return true;
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 데이터셋 변경시 체크
         *---------------------------------------------------------------------------------------------*/
        this.ds_input_oncolumnchanged = function(obj,e)
        {
        	switch(e.columnid)
        	{
        		case "UPJANG" :
        		case "UPJANG_NM" :
        			var nCnt1 = 0;
        			var nCnt2 = 0;
        			nCnt1 = this.ds_expt_upjang_list.getCaseCount("cd      == '" + e.newvalue + "'");
        			nCnt2 = this.ds_expt_upjang_list.getCaseCount("cdNm    == '" + e.newvalue + "'");
        			if(nCnt1 > 0 || nCnt2 > 0){
        				
        				if(e.columnid == "UPJANG"){
        					
        					this.ds_input.setColumn(0, "UPJANG"		, "");
        				}else{
        					application.goMain.gfn_Msg("OK", "알림", e.newvalue + " 업장은 추가구매 승인 예외 업장입니다.", "OK", "OK");
        					this.ds_input.setColumn(0, "UPJANG_NM"	, "");
        				}
        			}
        			break;
        	}	
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
        		
        		case "SEARCH" :	// 조회
        			if (this.ds_grd.rowcount < 1){
        				application.goMain.gfn_Msg("EE", "알림", "조회된 자료가 없습니다.", "OK", "OK");
        			}
        			break;
        			
        		case "SAVE" :	// 저장
        			application.goMain.gfn_Msg("ALERT_0", "Information", "저장되었습니다.", "OK");	//저장되었습니다
        			this.fn_search();	
        			break;
        		
        		case "CHK_SEARCH" :
        			if(this.ds_check.getRowCount() > 0){
        				application.goMain.gfn_Msg("duplication", "알림", "중복된 신청내역이 있습니다.\n확인해주십시오.", "OK", true, this);
        				return;
        			}
        			break;
        					
        		case "DELETE" :	// 삭제
        			if(nErrorCode!=0){
        				this.ds_grd.reset();
        				return;
        			}else{
        				this.fn_search();
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
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];	
        			this.ds_input.setColumn(0,"UPJANG"     ,this.upjang);		 // 업장코드
        			break;
        		case "additionAppDetailReqtPop":
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "START_DATE", rtn[0]);
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "END_DATE", rtn[1]);
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "REASON_CD", rtn[2]);
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "PR_REASON", rtn[3]);
        		    
        		    // 중복체크(server)
        			// this.fn_CheckSearch();
        			
        		    break;				
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			this.ds_input.setColumn(0,"FROM_DT"    ,rtn);		     // 일자(from)
        			break;	
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
        			this.ds_input.setColumn(0,"TO_DT"      ,rtn);		     // 일자(to)
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
        		
        	}	
        	
        	if (id == "confirm01") // 검색전 미저장 데이터 체크후 검색
        	{
        		if(rtn == "Y"){
        			this.fn_search();
        		}else if(rtn == "N"){
        			
        		}
        	}		
        	
        	// 저장처리할경우
        	if (id == "save")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save();
        		}
        		else
        		{
        			return;
        		}
        	}	
        	
        	// 삭제처리할경우
        	if (id == "delete")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_delete();
        		}
        		else
        		{
        			return;
        		}
        	}	
        	
        	// 중복체크(중복건이 있을경우) 입력건 초기화시킴
        	if (id == "duplication")
        	{
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "START_DATE", "");
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "END_DATE","");
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "REASON_CD", "");
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "PR_REASON", "");
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
        		if (this.ds_grd.getRowCount() > 0)
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

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_grd.addEventHandler("oncolumnchanged", this.ds_list_OnColumnChanged, this);
            this.ds_input.addEventHandler("oncolumnchanged", this.ds_input_oncolumnchanged, this);
            this.ds_del_list.addEventHandler("oncolumnchanged", this.ds_list_OnColumnChanged, this);
            this.ds_check_input.addEventHandler("oncolumnchanged", this.ds_input_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.btn_search.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);
            this.btn_delete.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.btn_addRow.addEventHandler("onclick", this.btn_addRow_onclick, this);
            this.btn_delRow.addEventHandler("onclick", this.btn_delRow_onclick, this);
            this.btn_save.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);

        };

        this.loadIncludeScript("AdditionAppReqt.xfdl", true);

       
    };
}
)();
