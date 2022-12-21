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
                this.set_name("EmergencyLoanReqt");
                this.set_titletext("임시여신신청");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/><Column id=\"creditReqGubun\" type=\"STRING\" size=\"256\"/><Column id=\"creditAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditTurnDays\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddEnd\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"apprYn\" type=\"STRING\" size=\"256\"/><Column id=\"headCreditYn\" type=\"STRING\" size=\"256\"/><Column id=\"reqUser\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdMainOffice", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjangDisp\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/><Column id=\"headCreditYn\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "467", "540", "10", null, null, this);
            obj.set_taborder("7");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("12");
            obj.set_text("요청자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_dept", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("요청부서");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "20", "20", "79", null, null, this);
            obj.set_taborder("15");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_requester", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("16");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "176", null, "59", "0", null, this);
            obj.set_taborder("18");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_mainOffice", "absolute", "139", "124", null, "47", "10", null, this);
            obj.set_taborder("0");
            obj.set_displaynulltext("본사를 선택하세요");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_mainOffice", "absolute", null, "124", "47", "47", "10", null, this);
            obj.set_taborder("17");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "182", null, "47", "114", null, this);
            obj.set_taborder("1");
            obj.set_displaynulltext("사업장을 선택하세요");
            obj.set_autoselect("true");
            obj.set_enable("false");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "182", "47", "47", "114", null, this);
            obj.set_taborder("21");
            obj.set_cssclass("btn_WF_EdtSearch");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "0", "234", null, "59", "0", null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "0", "234", "308", "59", null, null, this);
            obj.set_taborder("23");
            obj.set_text("(기존현황)임시여신");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "0", "292", null, "59", "0", null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_creditOverAmount", "absolute", "312", "240", null, "47", "9", null, this);
            obj.set_taborder("26");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_autoselect("true");
            obj.set_enable("false");
            obj.set_value("0");
            obj.set_displaynulltext("0");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "0", "350", null, "59", "0", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "0", "350", "308", "59", null, null, this);
            obj.set_taborder("28");
            obj.set_text("(신청내역)임시여신");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "0", "408", null, "59", "0", null, this);
            obj.set_taborder("29");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new TextArea("txt_bigo", "absolute", "10", "477", null, null, "10", "67", this);
            obj.set_taborder("4");
            obj.set_displaynulltext("신청사유를 입력하세요");
            obj.set_acceptstab("false");
            obj.set_imemode("hangul");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_list", "absolute", null, null, "117", "47", "150", "10", this);
            obj.set_taborder("34");
            obj.set_text("내역보기");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save", "absolute", null, null, "65", "47", "10", "10", this);
            obj.set_taborder("35");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "750", "540", "10", null, null, this);
            obj.set_taborder("36");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_new", "absolute", null, null, "65", "47", "80", "10", this);
            obj.set_taborder("37");
            obj.set_text("신규");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "390", "714", "5", "19", null, null, this);
            obj.set_taborder("38");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "460", "714", "5", "19", null, null, this);
            obj.set_taborder("5");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "0", "693", "540", "10", null, null, this);
            obj.set_taborder("40");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_creditOverEnd", "absolute", "312", "298", "219", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("42");
            obj.set_autoselect("true");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");
            obj.set_enable("false");
            obj.style.setStyleValue("align", "disabled", "center middle");

            obj = new Static("Static15", "absolute", "0", "477", "10", "216", null, null, this);
            obj.set_taborder("46");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "530", "477", "10", "273", null, null, this);
            obj.set_taborder("47");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "0", "292", "308", "59", null, null, this);
            obj.set_taborder("48");
            obj.set_text("(기존현황)임시여신종료일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "0", "409", "308", "59", null, null, this);
            obj.set_taborder("50");
            obj.set_text("(신청내역)임시여신종료일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "182", "100", "47", "10", null, this);
            obj.set_taborder("52");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_creditAddAmount", "absolute", "312", "356", null, "47", "9", null, this);
            obj.set_taborder("2");
            obj.set_value("0");
            obj.set_displaynulltext("0");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_autoselect("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "0", "118", "135", "59", null, null, this);
            obj.set_taborder("54");
            obj.set_text("본사");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "-1", "176", "135", "59", null, null, this);
            obj.set_taborder("55");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_creditAddEnd", "absolute", "312", "414", "219", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("57");
            obj.set_autoselect("true");
            obj.set_dateformat("yyyy-MM-dd");
            obj.style.set_align("center middle");

            obj = new Static("sta_creditAddEnd", "absolute", "313", "414", "218", "47", null, null, this);
            obj.set_taborder("58");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("임시여신신청");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item5","cal_creditAddEnd","value","ds_grd","creditAddEnd");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item3","msk_creditAddAmount","value","ds_grd","creditAddAmount");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item2","msk_creditOverAmount","value","ds_grd","creditOverAmount");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item4","cal_creditOverEnd","value","ds_grd","creditOverEnd");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item6","txt_bigo","value","ds_grd","remark");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("EmergencyLoanReqt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("EmergencyLoanReqt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		임시여신신청
        // [부시스템명]	임시여신신청
        // [설명]		    임시여신신청하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.02
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.02 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
        this.mainUpjang = undefined;
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
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(검색)
        	this.fn_SetBtnControl("this.btn_search","");
        		
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(내역보기)
        	this.fn_SetBtnControl("this.btn_list","");		
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(저장)
        	this.fn_SetBtnControl("","this.btn_save");		

        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_mainOffice", "this.btn_mainOffice");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	application.goMenu = this;	
        	
        	this.preDate = this.gfn_Today();
        	this.cal_creditAddEnd.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	//본사 세팅
        	this.fn_searchMainOffice();
        	
        	//부서세팅
        	this.edt_dept.set_value(application.g_Tm_Nm);
        	
        	//요청자세팅
        	this.edt_requester.set_value(application.g_Name); 
        	
        	
        	//여신통합여부(여신통합일경우 본사만/분리면 사업장까지 호출)
        	
        	
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.ds_grd.clearData();
        	this.ds_grdMainOffice.clearData();
        	
        // 	if(this.edt_upjang.value == ""){
        // 		this.btn_upjang_onclick();
        // 	}

        } 
         
        /** 
         * 본사 검색 팝업 호출
         */
        this.btn_mainoffice_onclick = function(obj,e)
        {
        	var arg = new Array();
        	//arg[0] = this.edt_mainOffice.value;
        	
        	application.goMain.gfn_POP_create("mainOfficeNm", "M_MLM::MainofficeSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	//arg[0] = this.edt_upjang.value;
        	arg[1] = this.upjang;
        	arg[2] = "FMS";
        	arg[3] = this.mainUpjang;
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 내역보기 팝업 호출
         */
        this.btn_list_onclick = function(obj,e)
        {	
        	var arg = new Array();
        	
        	application.goMain.gfn_POP_create("upjangHist", "M_MLM::EmergencyLoanReqtReportPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false; 		
        }

        //임시여신추가한도일(FROM)
        this.sta_creditAddEnd_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_creditAddEnd.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
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
        	this.fn_init();  
        	  
        	//필수항목 
        	if (this.fn_searchChk()) return;	  
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mlm/emergencyLoanReqt/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        
        /*******************************************************************************
        * 기      능   :  등록
        * 설      명   :  임시여신등록
        ********************************************************************************/
        this.btn_save_onclick = function(obj,e)
        {
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.ds_grd) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK", true, this);
        		return;
        	}
        	
         	//저장 체크
         	if(!this.fn_SaveCheck())
        	{
        		return;
        	}
        		
        	this.ds_grd.setColumn(0, "creditReqGubun", "02");  //구분 01: 런타임, 02:모바일
        	this.ds_grd.setColumn(0, "upjangnmDisp", this.edt_upjang.value); 	//요청업장명을 데이터셋에 담는다.
        	
        	//(기존현황)임시여신종료일이 없을경우 기존 임시여신(0) + 신청내역 임시여신금액을 신청금액으로 한다.	
        // 	if(application.gfn_IsNull(this.cal_creditOverEnd.value)){
        // 		var creditOverAmount = nexacro.toNumber(this.ds_grd.getColumn(0, "creditOverAmount")) + nexacro.toNumber(this.ds_grd.getColumn(0, "creditAddAmount"));
        // 	}else{
        		//(기존현황)임시여신종료일이 지난경우(현재일 기준) 신청내역 임시여신금액만 신청금액으로 한다.
        		//if(this.cal_creditOverEnd.value < this.preDate){
        	var creditOverAmount = nexacro.toNumber(this.ds_grd.getColumn(0, "creditAddAmount"));
        		//(기존현황)임시여신종료일이 지나지 않았을 경우(현재일 기준) 기존 임시여신 + 신청내역 임시여신금액을 신청금액으로 한다.	
        // 		}else{
        // 			var creditOverAmount = nexacro.toNumber(this.ds_grd.getColumn(0, "creditOverAmount")) + nexacro.toNumber(this.ds_grd.getColumn(0, "creditAddAmount"));
        // 		}	
        	//}
        	
        	//기존 한도액 세팅
        	this.ds_grd.setColumn(0, "creditBefAmount", this.ds_grd.getColumn(0, "creditOverAmount"));
        	
        	//기존 한도액 + 추가 한도액 세팅
        	this.ds_grd.setColumn(0, "creditOverAmount", creditOverAmount);
         	
         	//creditOverAmount 값이 null일경우 0값 세팅
         	if (application.gfn_IsNull(this.ds_grd.getColumn(0, "creditOverAmount"))) 
         	{
         		this.ds_grd.setColumn(0, "creditOverAmount", 0);
         	}  
         	
         	//creditAddAmount 값이 null일경우 0값 세팅
         	if (application.gfn_IsNull(this.ds_grd.getColumn(0, "creditAddAmount"))) 
         	{
         		this.ds_grd.setColumn(0, "creditAddAmount", 0);
         	}  
         	
         	//creditBefAmount 값이 null일경우 0값 세팅
         	if (application.gfn_IsNull(this.ds_grd.getColumn(0, "creditBefAmount"))) 
         	{
         		this.ds_grd.setColumn(0, "creditBefAmount", 0);
         	}  	
         	
         	//추가한도일 미 입력시 기존 한도일을 가져간다.
         	if (application.gfn_IsNull(this.ds_grd.getColumn(0, "creditAddEnd"))) 
         	{
         		this.ds_grd.setColumn(0, "creditAddEnd", this.ds_grd.getColumn(0, "creditOverEnd"));
         	}   		
         	
         	trace("ds_grd :: " +this.ds_grd.saveXML("ds_grd", "V"));
         	
        	var strSvcID   		 = "save";
        	var strUrl     		 = "ms/mlm/emergencyLoanReqt/saveList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        }

        
        /*******************************************************************************
        * 기      능   :  신규
        * 설      명   :  신규
        ********************************************************************************/
        this.btn_new_onclick = function(obj,e)
        {
        	this.ds_grd.clearData();
        	this.edt_mainOffice.set_value("");
        	this.edt_upjang.set_value("");
        	this.upjang = undefined;
        	
        }

        /*******************************************************************************
        * 기      능   :  화면 이동시
        * 설      명   :  데이터가 변경된 상태에서 화면 이동시 경고메세지 띄움
        ********************************************************************************/
        this.EmergencyLoanReqt_onkillfocus = function (obj,e)
        {
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.ds_grd) == true) 
        	{
        		alert("22222");
        		application.goMain.gfn_Msg("focusOut", "경고", "데이터가 변경되었습니다. 이동하시겠습니까?", "YN", true, this);
        	}
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if ( this.gfn_isNull(this.edt_mainOffice.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "본사를 입력하세요.", "OK", true, this);
        		return true;
        	}	
        	
        	if ( this.gfn_isNull(this.edt_upjang.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "사업장을 입력하세요.", "OK", true, this);
        		return true;
        	}	
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  저장체크
        * 설      명   :  저장체크
        ********************************************************************************/
        this.fn_SaveCheck = function ()
        {
        	var apprYn = this.ds_grd.getColumn(0, 'apprYn');
        	
         	if(apprYn == 'N')
         	{
         		application.goMain.gfn_Msg("ALERT_0", "Information", "미승인건입니다. 신청불가입니다", "OK");	
         		return false;
         	}
         	
         	if(this.gfn_isNull(this.msk_creditAddAmount.value) || this.gfn_isNull(this.cal_creditAddEnd.value))
         	{
         		application.goMain.gfn_Msg("ALERT_0", "Information", "임시여신 추가금액 또는 한도일을 입력하세요", "OK");	
         		return false;
         	}
         	
         	if(this.gfn_isNull(this.txt_bigo.value))
         	{
         		application.goMain.gfn_Msg("ALERT_0", "Information", "신청사유를 입력하세요.", "OK");	
         		return false;
         	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  본사코드 및 명 불러오기
        * 설      명   :  본사코드 및 명 불러오기
        ********************************************************************************/
        this.fn_searchMainOffice = function()
        {
        	var strSvcID   		 = "mainOffice";
        	var strUrl     		 = "ms/mlm/selectMainofficeSearchPopList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grdMainOffice=ds_list";
        	var strArguments	 = "upjangCd=" + nexacro.wrapQuote(this.upjang);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);  	
        	
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
        		//업장내역 조회
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();			
        			
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("ALERT_0", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    
                    mainUpjang = this.ds_grd.getColumn(0, "mainUpjang");
                    
                    
        			//본사 세팅
        			//this.fn_searchMainOffice();
                    
                    break;
          		//본사코드 및 명 불러오기
                case "mainOffice" :
        			
        			var headCreditYn = this.ds_grdMainOffice.getColumn(0, "headCreditYn");
        						
        			if(headCreditYn == "Y")
        			{
        				this.edt_mainOffice.set_value(this.ds_grdMainOffice.getColumn(0,"mainUpjangDisp"));
        				this.edt_upjang.set_value(this.ds_grdMainOffice.getColumn(0,"mainUpjangDisp"));
        				this.mainUpjang = this.ds_grdMainOffice.getColumn(0,"mainUupjang");
        				this.upjang = this.ds_grdMainOffice.getColumn(0,"upjang");
        				
        			}else{
        				this.edt_mainOffice.set_value(this.ds_grdMainOffice.getColumn(0,"mainUpjangDisp"));
        				this.mainUpjang = this.ds_grdMainOffice.getColumn(0,"mainUupjang");
        				this.upjang = this.ds_grdMainOffice.getColumn(0,"upjang");
        			}	
        				
        			break;		
          		//저장
          		case "save" :
        			// TODO parameter로 전체건수를 받는다.
        			
        			application.goMain.gfn_Msg("ALERT_0", "Information", "저장되었습니다.", "OK");	//저장되었습니다
        			//this.fn_search();
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
        		case "mainOfficeNm":
        			this.edt_mainOffice.set_value(rtn[1]);
        			this.mainUpjang = rtn[0];
        			
        			var headCreditYn = rtn[2];
        			
        			//여신통합관리여부
        			if(headCreditYn == "Y")
        			{
        				//본사코드를 사업장코드로 세팅해준다.
        				this.edt_upjang.set_value(rtn[1]);
        				this.upjang = rtn[0];
        				
        			}else{
        				this.edt_upjang.set_value("");
        			}	
        			
        			if (application.gfn_IsNull(this.mainUpjang)) {
        				this.edt_upjang.set_enable(false);
        				this.btn_upjang.set_enable(false);
        			}else{
        				this.edt_upjang.set_enable(true);
        				this.btn_upjang.set_enable(true);
        			}
        			
        			break;
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
        			//this.fn_search();
        			break;
        		case "PopCalFrom":
        			this.cal_creditAddEnd.set_value(rtn);
        			
        			if(this.cal_creditAddEnd.value < this.preDate)
        			{
        				application.goMain.gfn_Msg("ALERT_0", "Information", "현재일보다 이전일자 등록을 할수 없습니다. ", "OK");	
        				this.cal_creditAddEnd.set_value("");
        			}
         	
        			break;	
        		case "upjangHist":
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
        	}else if(id == "confirm")
        	{
        		if (rtn == "Y") 
        		{
        			alert("2222 >> " +application.updateChk);
        			application.updateChk = "false";
        		}
        		else
        		{
        			alert("33333 >> " +application.updateChk);
        			application.updateChk = "true";
        		}
        	}
        }

        /*******************************************************************************
        * 기      능   :  키패드 이동
        * 설      명   :  키페드 이동시 다음 탭 오더순으로 가도록 해줌
        ********************************************************************************/
        this.msk_creditAddAmount_onkeydown = function(obj,e)
        {
        	if(e.keycode == 13){this.getNextComponent(this.getFocus()).setFocus(); this.cal_creditAddEnd_oneditclick();}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.edt_mainOffice.addEventHandler("onchanged", this.edt_mainOffice_onchanged, this);
            this.btn_mainOffice.addEventHandler("onclick", this.btn_mainoffice_onclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.btn_list.addEventHandler("onclick", this.btn_list_onclick, this);
            this.btn_save.addEventHandler("onclick", this.btn_save_onclick, this);
            this.btn_new.addEventHandler("onclick", this.btn_new_onclick, this);
            this.cal_creditOverEnd.addEventHandler("ondropdown", this.cal_creditOverEnd_ondropdown, this);
            this.Static16.addEventHandler("onclick", this.Static16_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.msk_creditAddAmount.addEventHandler("onkeydown", this.msk_creditAddAmount_onkeydown, this);
            this.sta_creditAddEnd.addEventHandler("onclick", this.sta_creditAddEnd_onclick, this);

        };

        this.loadIncludeScript("EmergencyLoanReqt.xfdl", true);

       
    };
}
)();
