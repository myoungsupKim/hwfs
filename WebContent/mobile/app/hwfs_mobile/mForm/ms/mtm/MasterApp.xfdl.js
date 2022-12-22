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
                this.set_name("MasterApp");
                this.set_titletext("기획승인");
                this._setFormPosition(0,0,540,760);
            }

            
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
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"reqId\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"gubun\" type=\"STRING\" size=\"256\"/><Column id=\"gubunNm\" type=\"STRING\" size=\"256\"/><Column id=\"fromDt\" type=\"STRING\" size=\"256\"/><Column id=\"toDt\" type=\"STRING\" size=\"256\"/><Column id=\"fromToDt\" type=\"STRING\" size=\"256\"/><Column id=\"reqSabun\" type=\"STRING\" size=\"256\"/><Column id=\"reqSabunNm\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstSabun\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstCongubn\" type=\"STRING\" size=\"256\"/><Column id=\"apprSabun\" type=\"STRING\" size=\"256\"/><Column id=\"apprSabunNm\" type=\"STRING\" size=\"256\"/><Column id=\"apprGubun\" type=\"STRING\" size=\"256\"/><Column id=\"apprDate\" type=\"STRING\" size=\"256\"/><Column id=\"reasonCd\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"apprGubunType\" type=\"STRING\" size=\"256\"/><Column id=\"clsGubn\" type=\"STRING\" size=\"256\"/><Column id=\"prDate\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"upjang\"/><Col id=\"upjangNm\">추가발주 및 마감취소 승인 GRID</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_gubunCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_common", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdTicket", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"ticketSeq\" type=\"STRING\" size=\"256\"/><Column id=\"ticketGroupSeq\" type=\"STRING\" size=\"256\"/><Column id=\"gubunNm\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"itemType\" type=\"STRING\" size=\"256\"/><Column id=\"itemTypenm\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemCodenm\" type=\"STRING\" size=\"256\"/><Column id=\"transDd\" type=\"STRING\" size=\"256\"/><Column id=\"transType\" type=\"STRING\" size=\"256\"/><Column id=\"transTypenm\" type=\"STRING\" size=\"256\"/><Column id=\"transGubun\" type=\"STRING\" size=\"256\"/><Column id=\"transGubunnm\" type=\"STRING\" size=\"256\"/><Column id=\"uprice\" type=\"STRING\" size=\"256\"/><Column id=\"qty\" type=\"STRING\" size=\"256\"/><Column id=\"amt\" type=\"STRING\" size=\"256\"/><Column id=\"ticketStartnum\" type=\"STRING\" size=\"256\"/><Column id=\"ticketEndnum\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"autoGubun\" type=\"STRING\" size=\"256\"/><Column id=\"autoKind\" type=\"STRING\" size=\"256\"/><Column id=\"autoKindnm\" type=\"STRING\" size=\"256\"/><Column id=\"sourceId\" type=\"STRING\" size=\"256\"/><Column id=\"requestSabun\" type=\"STRING\" size=\"256\"/><Column id=\"requestSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"requestDate\" type=\"STRING\" size=\"256\"/><Column id=\"disuseDate\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstSabun\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstCongubn\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstCongubnnm\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstDate\" type=\"STRING\" size=\"256\"/><Column id=\"approvSabun\" type=\"STRING\" size=\"256\"/><Column id=\"approvSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"approvCongubn\" type=\"STRING\" size=\"256\"/><Column id=\"approvCongubnnm\" type=\"STRING\" size=\"256\"/><Column id=\"approvDate\" type=\"STRING\" size=\"256\"/><Column id=\"congubnDesc\" type=\"STRING\" size=\"256\"/><Column id=\"teamMstCongubnDesc\" type=\"STRING\" size=\"256\"/><Column id=\"ticketMaxnum\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"upjangnm\">식권폐기승인 GRID</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_close", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"upjangCd\" type=\"STRING\" size=\"256\"/><Column id=\"occurDate\" type=\"STRING\" size=\"256\"/><Column id=\"sysClass\" type=\"STRING\" size=\"256\"/><Column id=\"closeYn\" type=\"STRING\" size=\"256\"/><Column id=\"rowStatus\" type=\"STRING\" size=\"256\"/><Column id=\"closeGubun\" type=\"STRING\" size=\"256\"/><Column id=\"reqId\" type=\"STRING\" size=\"256\"/><Column id=\"loginSabun\" type=\"STRING\" size=\"256\"/><Column id=\"occurSdate\" type=\"STRING\" size=\"256\"/><Column id=\"occurEdate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "113", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("신청월");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "93", "17", "20", "29", null, null, this);
            obj.set_taborder("15");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_gubun", "absolute", "275", "8", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("48");
            obj.set_innerdataset("@ds_gubunCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_displaynulltext("구분");
            obj.set_index("-1");

            obj = new Calendar("cal_dtFrom", "absolute", "113", "8", "155", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("49");
            obj.set_dateformat("yyyy-MM");
            obj.set_value("null");
            obj.set_editformat("yyyy-MM");

            obj = new Button("btn_search", "absolute", null, "64", "100", "47", "10", null, this);
            obj.set_taborder("50");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Button("btn_chkDel", "absolute", null, "65", "117", "47", "286", null, this);
            obj.set_taborder("51");
            obj.set_text("전체해제");
            this.addChild(obj.name, obj);

            obj = new Button("btn_return", "absolute", null, "65", "65", "47", "146", null, this);
            obj.set_taborder("52");
            obj.set_text("반려");
            obj.set_cssclass("btn_WF_Function");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_approve", "absolute", null, "65", "65", "47", "216", null, this);
            obj.set_taborder("53");
            obj.set_text("승인");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_chkAll", "absolute", null, "65", "117", "47", "408", null, this);
            obj.set_taborder("54");
            obj.set_text("전체선택");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "118", null, null, "0", "0", this);
            obj.set_taborder("55");
            obj.set_binddataset("ds_grd");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_visible("false");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"10\"/><Column size=\"40\"/><Column size=\"280\"/><Column size=\"210\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"12\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"12\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column1\"/><Cell col=\"3\" text=\"Column2\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"1\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"2\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"3\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell row=\"1\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" displaytype=\"checkbox\" edittype=\"checkbox\" style=\"line:0 none;\" text=\"bind:chk\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"2\" colspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:upjangNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:fromToDt\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"3\" style=\"line:0 none;\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:gubunNm\" autosizerow=\"limitmin\"/><Cell row=\"3\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"1\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"2\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"3\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "10", "71", "5", "29", null, null, this);
            obj.set_taborder("57");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "132", "71", "5", "29", null, null, this);
            obj.set_taborder("58");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "254", "71", "5", "29", null, null, this);
            obj.set_taborder("59");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "324", "71", "5", "29", null, null, this);
            obj.set_taborder("60");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list005", "absolute", "0", "190", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("62");
            obj.set_binddataset("ds_grdTicket");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_visible("false");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"10\"/><Column size=\"40\"/><Column size=\"280\"/><Column size=\"210\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"12\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"12\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column1\"/><Cell col=\"3\" text=\"Column2\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"1\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"2\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell col=\"3\" style=\"line:0 none;\" autosizerow=\"limitmax\"/><Cell row=\"1\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" displaytype=\"checkbox\" edittype=\"checkbox\" style=\"line:0 none;\" text=\"bind:chk\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"2\" colspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:upjangnm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:requestDate\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"3\" style=\"line:0 none;\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:gubunNm\" autosizerow=\"limitmin\"/><Cell row=\"3\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"1\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"2\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"3\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("61");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "113", "8", "155", "47", null, null, this);
            obj.set_taborder("67");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("기획승인");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("MasterApp.xfdl", "lib::lib_Com.xjs");
        this.registerScript("MasterApp.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		기획승인
        // [부시스템명]	기획승인 - 조회, 승인
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.11.11
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.11.11 : 강대성 : 수정이 필요하여 수정함.
        // 2015.11.11 : 강대성 : 기획승인 로직 추가 수정.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;           //현재일자
        this.preDateMonth = undefined;   	//현재월
        this.fv_totalpageRow;	        	//전체건수
        this.muCd = undefined;          	//사업부코드
        this.tmCd = undefined;          	//팀코드
        this.gubun = undefined;         	//팀장승인 구분
        this.apprGubunType = undefined;		//승인구분
        this.outDatasetGubun = undefined;	//아웃데이터셋 변수
        this.inDatasetGubun = undefined;	//인데이터셋 변수
        this.dsGubun = undefined;			//데이터셋 변수
        this.grdGubun = undefined;			//그리드 변수
        this.chkGubun = undefined;			//마스터 및 팀 구분 변수
        this.saveGubun = undefined;			//마감취소시 마스터 및 팀 구분 변수 
        this.clsGubn  = undefined;
        this.savYn = undefined;

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

        // 초기화
        this.fn_init = function ()
        {
        	//공통코드호출(PC RUNTIME 권한 메뉴 호출)
        	this.fn_comboMenuAuth();
        	//시험접수승인(LIMS)경우 별도의 권한을 가져가기 떄문에 권한 정보 함수 호출
        	this.fn_limsAuthLevels();
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(승인버튼)
        	this.fn_SetBtnControl("","this.btn_approve");	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(반려버튼)
        	this.fn_SetBtnControl("","this.btn_return");	
        	
        	this.savYn = application.gds_cmnAuth.getColumn(0, "savYn")

        	//현재월 
        	this.preDate = this.gfn_Today();
        	this.preDateMonth = this.gfn_subStr(this.preDate,0,6);
        	
        	this.cal_dtFrom.set_value(this.preDate);
        	
        	this.muCd = application.g_Mu_Cd;
        	this.tmCd = application.g_Tm_Cd;
        	
        	//기획승인 콤보 등록 구분
        	this.fn_common_code("MS003", "", "", "MASTERAPP");	
        	this.ds_gubunCd.copyData(application.gds_common_code);
        	
        	//위치값 조정
        	this.grd_list005.set_top(this.grd_list.top);
        	
        	this.chkGubun = "approv"
        	
        }

        //데이터셋 초기화
        this.fn_dataset_init = function ()
        {
        	this.ds_grd.clearData();
        	this.ds_grdTicket.clearData();
        	this.btn_moreView.set_visible(false);
        }

        // 월달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", application.goMain.divBase.div_calendarMonth, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
        	return false;
        }

        //구분 콤보조회 검색 팝업
        this.cbo_gubun_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_gubunCd;
        	arg[1] = "조회조건(승인구분)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("gubun", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //반려버튼 클릭시 반려사유등록 팝업 호출
        this.btn_return_onclick = function(obj,e)
        {	
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.dsGubun) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "반려할 목록을 선택하세요.", "OK", true, this);
        		return;
        	}	
        	
        	var cnt = 0;
        	var i;
        	for (i = 0; i < this.dsGubun.rowcount; i++)
        	{
        		cnt += nexacro.toNumber(this.dsGubun.getColumn(i, "chk"));
        	}
        	
        	if(cnt > 1){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "반려는 한건씩 할 수 있습니다.", "OK", true, this);
        		return;
        	}else if(cnt == 0){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "반려할 목록을 선택하세요.", "OK", true, this);
        		return;
        	}
        	
        	application.goMain.gfn_POP_create("returnComment", "M_MLM::ReturnReasonReqtPop.xfdl", "fn_callbackPOP", this, "", "POP", application.goMain.divBase);
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
        	//데이터셋 초기화
        	this.fn_dataset_init();

        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	var reqDate = this.gfn_subStr(this.cal_dtFrom.value,0,6);
        	var gubun = this.ds_gubunCd.getColumn(this.gubun, "cd");
        	
        	//ALL:마감취소승인(전체), 001:매출마감(급식), 004:재고마감, 005:급식운영일지마감, 006:매출마감(장례식장), 008:매출마감(폐식용유), 009:매출마감(특판), 011:건별취소(급식), 012:매출마감(외식)
        	if(gubun == "ALL" || gubun == "001" || gubun == "006" || gubun == "008" || gubun == "009" || gubun == "011" || gubun == "012"){
        		this.apprGubunType = "002"
        		this.grd_list.set_visible(true);
        		this.grd_list005.set_visible(false);
        		this.btn_return.set_visible(false);
        		this.outDatasetGubun = "ds_grd=ds_list";
        		this.grdGubun = this.grd_list;		
         	//식권폐기관리
         	}else if(gubun == "015"){		
        		this.apprGubunType = "005"
        		this.grd_list.set_visible(false);
        		this.grd_list005.set_visible(true);	
        		this.btn_return.set_visible(true);
        		this.outDatasetGubun = "ds_grdTicket=ds_list";
        		this.grdGubun = this.grd_list005;
        		this.tmCd = "";
        	}		
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mtm/teamLeaderApp/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = this.outDatasetGubun;
        	var strArguments	 = "muCd=" + nexacro.wrapQuote(this.muCd)
        		strArguments     += " tmCd=" + nexacro.wrapQuote(this.tmCd);
        		strArguments     += " reqDate=" + nexacro.wrapQuote(reqDate);
        		strArguments     += " gubun=" + nexacro.wrapQuote(gubun);
        		strArguments     += " apprGubunType=" + nexacro.wrapQuote(this.apprGubunType);
        		strArguments     += " chkGubun=" + nexacro.wrapQuote(this.chkGubun);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  등록
        * 설      명   :  임시여신등록
        ********************************************************************************/
        this.fn_save = function()
        {
        	// v_ds_check 미사용시 변경사항 체크
        	var cnt = 0;
        	var i;
        	for (i = 0; i < this.dsGubun.rowcount; i++)
        	{
        		cnt += nexacro.toNumber(this.dsGubun.getColumn(i, "chk"));
        	}
        	
        	if(cnt == 0){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "승인할 목록을 선택하세요.", "OK", true, this);
        		return;
        	}
        	
        	var gubun = this.ds_gubunCd.getColumn(this.gubun, "cd");
        	
        	//ALL:마감취소승인(전체), 001:매출마감(급식), 004:재고마감, 005:급식운영일지마감, 006:매출마감(장례식장), 008:매출마감(폐식용유), 009:매출마감(특판), 011:건별취소(급식), 012:매출마감(외식)
        	if(gubun == "ALL" || gubun == "001" || gubun == "006" || gubun == "008" || gubun == "009" || gubun == "011" || gubun == "012"){
        		this.apprGubunType = "002"
        		this.inDatasetGubun = "ds_list=ds_grd:U";
        		this.clsGubn = this.ds_grd.getColumn(this.ds_grd.rowposition, "clsGubn");
        		if(this.chkGubun == "approv")
        		{
        			this.saveGubun = "saveApprov";
        		}
        		else
        		{
        			this.saveGubun = "";
        		}
         	//식권폐기관리
         	}else if(gubun == "015"){
        		this.apprGubunType = "005"
        		this.inDatasetGubun = "ds_list=ds_grdTicket:U";
        	}
         	
         	if(this.apprGubunType == "002"){	
        		
        		//저장 체크
        		if(!this.fn_SaveCheck002())
        		{
        			return;
        		}
        		
         	}  	
        	
        	// 취소기획승인경우
        	if(this.apprGubunType == "002" && this.saveGubun == "saveApprov")
        	{
        		
        		// 매출 프로시져
        		for(var i = 0; i<this.ds_grd.rowcount; i++)
        		{
        			if(this.ds_grd.getColumn(i, "chk") == "1")
        			{
        				if(this.ds_grd.getColumn(i, "gubun") == "001"){//매출(급식)	
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "occurSdate",	this.ds_grd.getColumn(i, "fromDt"));
        					this.ds_close.setColumn(0, "occurEdate",	this.ds_grd.getColumn(i, "toDt"));
        					this.ds_close.setColumn(0, "sysClass"  , 	"11");
        					this.ds_close.setColumn(0, "upjangCd"  ,	this.ds_grd.getColumn(i, "upjang"));
        					this.ds_close.setColumn(0, "closeGubun",	"001");
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ma/mas/closeMgmt/saveList.xdo";
        					var strInDataset     = "ds_close=ds_close:U";
        					var strOutDataset    = "";
        					var strArguments	 = "";
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        					
        				}else if(this.ds_grd.getColumn(i, "gubun") == "006"){//매출(장례식)
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "occurSdate",	this.ds_grd.getColumn(i, "fromDt"));
        					this.ds_close.setColumn(0, "occurEdate",	this.ds_grd.getColumn(i, "toDt"));
        					this.ds_close.setColumn(0, "sysClass"  , 	"16");
        					this.ds_close.setColumn(0, "upjangCd"  ,	this.ds_grd.getColumn(i, "upjang"));
        					this.ds_close.setColumn(0, "closeGubun",	"006");
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ma/mas/closeMgmt/saveList.xdo";
        					var strInDataset     = "ds_close=ds_close:U";
        					var strOutDataset    = "";
        					var strArguments	 = "";
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        					
        				}else if(this.ds_grd.getColumn(i, "gubun") == "008"){//매출(폐식용유)
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "occurSdate",	this.ds_grd.getColumn(i, "fromDt"));
        					this.ds_close.setColumn(0, "occurEdate",	this.ds_grd.getColumn(i, "toDt"));
        					this.ds_close.setColumn(0, "sysClass"  , 	"19");
        					this.ds_close.setColumn(0, "upjangCd"  ,	this.ds_grd.getColumn(i, "upjang"));
        					this.ds_close.setColumn(0, "closeGubun",	"008");
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ma/mas/closeMgmt/saveList.xdo";
        					var strInDataset     = "ds_close=ds_close:U";
        					var strOutDataset    = "";
        					var strArguments	 = "";
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        					
        				}else if(this.ds_grd.getColumn(i, "gubun") == "009"){//매출(특판)
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "occurSdate",	this.ds_grd.getColumn(i, "fromDt"));
        					this.ds_close.setColumn(0, "occurEdate",	this.ds_grd.getColumn(i, "toDt"));
        					this.ds_close.setColumn(0, "sysClass"  , 	"17");
        					this.ds_close.setColumn(0, "upjangCd"  ,	this.ds_grd.getColumn(i, "upjang"));
        					this.ds_close.setColumn(0, "closeGubun",	"009");
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ma/mas/closeMgmt/saveList.xdo";
        					var strInDataset     = "ds_close=ds_close:U";
        					var strOutDataset    = "";
        					var strArguments	 = "";
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        					
        				}else if(this.ds_grd.getColumn(i, "gubun") == "011"){//건별취소(급식)
        					
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "chk"       ,	this.ds_grd.getColumn(i, "chk"));
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ms/mtm/teamLeaderApp/saveList.xdo";
        					var strInDataset     = "ds_list=ds_close:U";
        					var strOutDataset    = this.outDatasetGubun;
        					var strArguments	 = "apprGubunType=" + nexacro.wrapQuote(this.apprGubunType);
        						strArguments     += " chkGubun=" + nexacro.wrapQuote(this.chkGubun);
        						strArguments     += " clsGubn=" + nexacro.wrapQuote(this.clsGubn);
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        		
        				}else if(this.ds_grd.getColumn(i, "gubun") == "012"){//매출마감(외식))
        					this.ds_close.clearData();
        					this.ds_close.addRow();
        					this.ds_close.setColumn(0, "occurSdate",	this.ds_grd.getColumn(i, "fromDt"));
        					this.ds_close.setColumn(0, "occurEdate",	this.ds_grd.getColumn(i, "toDt"));
        					this.ds_close.setColumn(0, "sysClass"  , 	"12");
        					this.ds_close.setColumn(0, "upjangCd"  ,	this.ds_grd.getColumn(i, "upjang"));
        					this.ds_close.setColumn(0, "closeGubun",	"012");
        					this.ds_close.setColumn(0, "reqId"	   ,	this.ds_grd.getColumn(i, "reqId"));
        					this.ds_close.setColumn(0, "loginSabun",    application.g_EmpNo);
        					
        					var strSvcID   		 = "save";
        					var strUrl     		 = "ma/mas/closeMgmt/saveList.xdo";
        					var strInDataset     = "ds_close=ds_close:U";
        					var strOutDataset    = "";
        					var strArguments	 = "";
        					var strCallbackFunc	 = "fn_callBack";
        					var bAsync			 = true;

        					this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        					
        				}				
        			}				
        		}			
        	}
        	else
        	{
        		var strSvcID   		 = "save";
        		var strUrl     		 = "ms/mtm/teamLeaderApp/saveList.xdo";
        		var strInDataset     = this.inDatasetGubun;
        		var strOutDataset    = this.outDatasetGubun;
        		var strArguments	 = "apprGubunType=" + nexacro.wrapQuote(this.apprGubunType);
        			strArguments     += " chkGubun=" + nexacro.wrapQuote(this.chkGubun);
        			strArguments     += " clsGubn=" + nexacro.wrapQuote(this.clsGubn);
        		var strCallbackFunc	 = "fn_callBack";
        		var bAsync			 = true;

        		this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        		// connect the server 
        	}	
        }

        /*******************************************************************************
        * 기      능   :  반려등록
        * 설      명   :  팀장승인건 반려처리
        ********************************************************************************/
        this.fn_saveReturn = function()
        {
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.dsGubun) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "반려할 목록을 선택하세요.", "OK", true, this);
        		return;
        	}	
        	
        	var gubun = this.ds_gubunCd.getColumn(this.gubun, "cd");
        	
        	//ALL:마감취소승인(전체), 001:매출마감(급식), 004:재고마감, 005:급식운영일지마감, 006:매출마감(장례식장), 008:매출마감(폐식용유), 009:매출마감(특판), 011:건별취소(급식), 012:매출마감(외식)
        	if(gubun == "ALL" || gubun == "001" || gubun == "006" || gubun == "008" || gubun == "009" || gubun == "011" || gubun == "012"){
        		this.apprGubunType = "002"
        		this.inDatasetGubun = "ds_list=ds_grd:U";
         	//식권폐기관리
         	}else if(gubun == "015"){
        		this.apprGubunType = "005"
        		this.inDatasetGubun = "ds_list=ds_grdTicket:U";
         	}
        	
        	var strSvcID   		 = "saveReturn";
        	var strUrl     		 = "ms/mtm/teamLeaderApp/saveReturnList.xdo";
        	var strInDataset     = this.inDatasetGubun;
        	var strOutDataset    = this.outDatasetGubun;
        	var strArguments	 = "apprGubunType=" + nexacro.wrapQuote(this.apprGubunType);
        		strArguments     += " chkGubun=" + nexacro.wrapQuote(this.chkGubun);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        	// connect the server	
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if ( this.gfn_isNull(this.cal_dtFrom.value) || (this.gfn_Length(this.cal_dtFrom.value)< 6) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "신청월을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.gubun))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "구분을 선택해주세요", "OK", true, this);
        		return true;
        	}		
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  (마감취소)저장체크
        * 설      명   :  (마감취소)저장체크
        ********************************************************************************/
        this.fn_SaveCheck002 = function ()
        {
        	this.fn_common_code("MA0044", this.gfn_subStr(this.ds_grd.getColumn(this.ds_grd.rowposition, "fromDt"),0,6),"","","AND CODE_NAME = 'Y' AND USE_YN = 'Y'");
        	trace("application.gds_common_code222 :: " +application.gds_common_code.saveXML("gds_common_code", "V"));
        	
        	if(application.gds_common_code.rowcount > 0){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "해당월은 월마감이 완료되어 취소가 불가합니다.", "OK", true, this);
        		return false;
        	}
        	
        	if(this.gfn_subStr(this.ds_grd.getColumn(this.ds_grd.rowposition, "fromDt"),0,6) != this.gfn_subStr(this.ds_grd.getColumn(this.ds_grd.rowposition, "toDt"),0,6)){
        		this.fn_common_code("MA0044", this.gfn_subStr(this.ds_grd.getColumn(this.ds_grd.rowposition, "toDt"),0,6),"","","AND CODE_NAME = 'Y' AND USE_YN = 'Y'");
        		if(application.gds_common_code.rowcount > 0){		
        			application.goMain.gfn_Msg("ALERT_0", "알림", "해당월은 월마감이 완료되어 취소가 불가합니다.", "OK", true, this);
        			return false;		
        		}
        	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  그리드 cell클릭시
        * 설      명   :  그리드 cell클릭시 상세내용팝업창을 호출한다
        ********************************************************************************/ 

        /*----------------------------------------------------------------------------------------------
         * 설명      : 마감취소승인 상세내용 팝업창 호출
         *---------------------------------------------------------------------------------------------*/
        this.grd_list_oncellclick = function(obj,e)
        {	
        	//alert(e.cell);
        	if(e.cell != "5"){
        		var arg = new Array();
        		arg[0] = this.apprGubunType;
        		arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "remark");
        		arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reasonCd");
        		
        		application.goMain.gfn_POP_create("teamLeaderAppDetailPop", "M_MTM::TeamLeaderAppDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	}
        	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 식권폐기승인 상세내용 팝업창 호출
         *---------------------------------------------------------------------------------------------*/
        this.grd_list005_oncellclick = function(obj,e)
        {
        	//alert(e.cell);
        	if(e.cell != "5"){
        		var arg = new Array();
        		arg[0] = this.apprGubunType;
        		arg[1] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "transGubunnm");    //구분
        		arg[2] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "itemTypenm");      //식권종류
        		arg[3] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "itemCode");        //자재코드
        		arg[4] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "uprice");          //단가
        		arg[5] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "qty");             //수량
        		arg[6] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "amt");             //금액
        		arg[7] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "ticketStartnum");  //시작번호
        		arg[8] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "ticketEndnum");    //종료번호
        		arg[9] = this.ds_grdTicket.getColumn(this.ds_grdTicket.rowposition, "remark");          //적요
        		
        		application.goMain.gfn_POP_create("teamLeaderAppDetailPop", "M_MTM::TeamLeaderAppTicketDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	}
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
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			
        			// 마감취소승인 조회
        			if(this.apprGubunType == "002"){
        				this.fv_totalpageRow = this.ds_grd.getRowCount();
        				this.dsGubun = this.ds_grd;
        			// 식권폐기승인
        			}else if(this.apprGubunType == "005"){
        				this.fv_totalpageRow = this.ds_grdTicket.getRowCount();
        				this.dsGubun = this.ds_grdTicket;
        			}
        			
        			// 조회 건수 확인  
                    if (this.dsGubun.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        this.btn_moreView.set_visible(false);
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				// 마감취소승인 조회
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.set_text("총건수:" +this.fv_totalpageRow);
        			}
        			
          			break;
          		//저장
          		case "save" :
        			// TODO parameter로 전체건수를 받는다.
        			
        			application.goMain.gfn_Msg("ALERT_1", "Information", "승인되었습니다.", "OK", true, this);	//저장되었습니다
        			
        			//승인처리시 BadgeCount갱신처리함
        			application.goMain.fn_getCnt(1);
        			
        			break;
                //저장
          		case "saveReturn" :
        			// TODO parameter로 전체건수를 받는다.
        			
        			application.goMain.gfn_Msg("ALERT_1", "Information", "반려되었습니다.", "OK", true, this);	//저장되었습니다
        			
        			//반려처리시 BadgeCount갱신처리함
        			application.goMain.fn_getCnt(1);
        			
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
        		case "gubun":
        			this.cbo_gubun.set_index(rtn);
        			this.gubun = rtn;
        			
        			var gubun = this.ds_gubunCd.getColumn(this.gubun, "cd");
        			
        			// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(승인버튼)
        			this.fn_SetBtnControl("","this.btn_approve");	
        				
        			// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(반려버튼)
        			this.fn_SetBtnControl("","this.btn_return");				
        						
        			this.fn_search();
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;
        		case "teamLeaderAppDetailPop":
        			break;	
        		case "returnComment":	
        			//추가발주승인 및 마감취소승인 조회
        			if(this.apprGubunType == "002"){
        			
        			//식권폐기승인
        			}else if(this.apprGubunType == "005"){
        				this.dsGubun.setColumn(this.dsGubun.rowposition, "teamMstCongubnDesc", rtn[0]);	
        			}	
        			this.fn_saveReturn();
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
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        	
        	if (id == "ALERT_1") // 조회 시 오류
        	{
        		//승인 또는 반려 처리후 다시 조회한다
        		this.fn_search();
        	}		
        }

        // 전체 체크
        this.btn_chkAll_onclick = function(obj,e)
        {
        	var i;
        	
        	for (i = 0; i < this.dsGubun.rowcount; i++)
        	{
        		this.dsGubun.setColumn(i, "chk", 1);
        	}
        }

        // 체크 전체 해제
        this.btn_chkDel_onclick = function(obj,e)
        {
        	var i;
        	for (i = 0; i < this.dsGubun.rowcount; i++)
        	{
        		this.dsGubun.setColumn(i, "chk", 0);
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
        		this.btn_moreView.style.set_opacity(75);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		this.btn_moreView.style.set_opacity(45);
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grdGubun.vscrollbar.set_pos(0);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.cbo_gubun.addEventHandler("ondropdown", this.cbo_gubun_ondropdown, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btn_chkDel.addEventHandler("onclick", this.btn_chkDel_onclick, this);
            this.btn_return.addEventHandler("onclick", this.btn_return_onclick, this);
            this.btn_approve.addEventHandler("onclick", this.fn_save, this);
            this.btn_chkAll.addEventHandler("onclick", this.btn_chkAll_onclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list005.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list005.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list005.addEventHandler("oncellclick", this.grd_list005_oncellclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("MasterApp.xfdl", true);

       
    };
}
)();
