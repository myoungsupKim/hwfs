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
                this.set_name("ClaimProcessDetailReportPop");
                this.set_titletext("클레임신청상세등록");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,628);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_processTypeCd", this);
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

            obj = new Dataset("ds_claimTypeCd", this);
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

            obj = new Dataset("ds_listqty", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"checked\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"itemCode\" type=\"STRING\" size=\"255\"/><Column id=\"itemName\" type=\"STRING\" size=\"255\"/><Column id=\"itemSize\" type=\"STRING\" size=\"255\"/><Column id=\"poUom\" type=\"STRING\" size=\"255\"/><Column id=\"custcd\" type=\"STRING\" size=\"255\"/><Column id=\"custnm\" type=\"STRING\" size=\"255\"/><Column id=\"poQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"reqQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"ctClaimKind\" type=\"STRING\" size=\"255\"/><Column id=\"reqDate\" type=\"STRING\" size=\"255\"/><Column id=\"reqTime\" type=\"STRING\" size=\"255\"/><Column id=\"reqKind\" type=\"STRING\" size=\"255\"/><Column id=\"claimMemo\" type=\"STRING\" size=\"255\"/><Column id=\"prcsStatus\" type=\"STRING\" size=\"255\"/><Column id=\"dlvyKind\" type=\"STRING\" size=\"255\"/><Column id=\"createBy\" type=\"STRING\" size=\"255\"/><Column id=\"mobileGubun\" type=\"STRING\" size=\"255\"/><Column id=\"photo\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"poId\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"centerCode\" type=\"STRING\" size=\"255\"/><Column id=\"subinvCode\" type=\"STRING\" size=\"255\"/><Column id=\"upjang\" type=\"STRING\" size=\"255\"/><Column id=\"needDate\" type=\"STRING\" size=\"255\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "629", null, null, this);
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

            obj = new Static("Static02", "absolute", "442", "618", "102", "10", null, null, this);
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

            obj = new Static("Static04", "absolute", "510", "588", "10", "100", null, null, this);
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

            obj = new MaskEdit("msk_reqQty", "absolute", "610", "86", null, "47", "-238", null, this);
            obj.set_taborder("21");
            obj.set_mask("#,##0.0");
            obj.style.set_padding("0 10 0 10");
            obj.style.set_align("right middle");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            obj.set_autoselect("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "10", "138", null, "59", "10", null, this);
            obj.set_taborder("22");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_ctClaimKind", "absolute", "196", "144", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("23");
            obj.set_innerdataset("@ds_claimTypeCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Static("Static07", "absolute", "10", "196", null, "59", "10", null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_reqKind", "absolute", "196", "202", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("25");
            obj.set_innerdataset("ds_processTypeCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new TextArea("txt_claimMemo", "absolute", "196", "261", null, "88", "10", null, this);
            obj.set_taborder("26");
            obj.set_imemode("hangul");
            obj.set_autoselect("false");
            obj.set_acceptstab("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "10", "354", null, "59", "10", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_reqDate", "absolute", "196", "360", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("28");
            obj.set_dateformat("yyyy-MM-dd");
            obj.style.set_padding("0 10 0 0");
            obj.set_value("null");
            obj.set_autoselect("true");

            obj = new Static("Static10", "absolute", "10", "412", null, "59", "10", null, this);
            obj.set_taborder("29");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_reqTime", "absolute", "196", "418", null, "47", "10", null, this);
            obj.set_taborder("30");
            obj.set_mask("##:##");
            obj.style.set_padding("0 10 0 10");
            obj.style.set_align("left middle");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            obj.set_type("string");
            obj.set_autoselect("true");
            obj.set_trimtype("both");
            obj.set_maskchar("_");
            obj.set_clipmode("includespace");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new TextArea("txt_etcMemo", "absolute", "196", "477", null, "88", "10", null, this);
            obj.set_taborder("31");
            obj.set_imemode("hangul");
            obj.set_autoselect("false");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save", "absolute", "445", "571", "65", "47", null, null, this);
            obj.set_taborder("32");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_dlvyQty", "absolute", "196", "86", "161", "47", null, null, this);
            obj.set_taborder("33");
            obj.set_mask("#,##0.0");
            obj.set_autoselect("false");
            obj.style.set_padding("0 10 0 10");
            obj.style.set_align("right middle");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "10", "80", "182", "59", null, null, this);
            obj.set_taborder("34");
            obj.set_text("입고량/요청량");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "10", "139", "169", "59", null, null, this);
            obj.set_taborder("36");
            obj.set_text("클레임유형");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "10", "196", "169", "59", null, null, this);
            obj.set_taborder("37");
            obj.set_text("요청사항");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "10", "274", "154", "59", null, null, this);
            obj.set_taborder("38");
            obj.set_text("클레임상세");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "10", "354", "198", "59", null, null, this);
            obj.set_taborder("39");
            obj.set_text("입고요청일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "10", "412", "200", "59", null, null, this);
            obj.set_taborder("40");
            obj.set_text("입고요청시간");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "10", "491", "169", "59", null, null, this);
            obj.set_taborder("41");
            obj.set_text("기타사항");
            obj.set_cssclass("sta_WF_Label02");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("sta_reqDate", "absolute", "196", "360", "314", "47", null, null, this);
            obj.set_taborder("42");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_reqQty", "absolute", "363", "86", "147", "47", null, null, this);
            obj.set_taborder("43");
            obj.style.set_align("right middle");
            obj.set_inputtype("number,dot");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 628, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("클레임신청상세등록");
            		p.set_scrollbars("none");
            		p.set_enable("true");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item6","txt_claimMemo","value","ds_grd00","remark");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item0","txt_etcMemo","value","ds_grd00","remark");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ClaimProcessDetailReqtPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ClaimProcessDetailReqtPop.xfdl", function(exports) {
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
        this.preDate = undefined; //현재날짜
        this.preDateTime = undefined; //현재날짜 + 시간(시분)
        this.inputDateTime = undefined; //입고요청일자 + 입고요청시간(시분)
        this.fv_totalpageRow;	// 전체건수
        this.reqNum = undefined;

        this.reqQty = undefined;
        this.ctClaimKind = undefined;
        this.reqKind = undefined;
        this.claimMemo = undefined;
        this.reqDate = undefined;
        this.reqTime = undefined;
        this.etcMemo = undefined;

        this.vRtn = 0;
        this.vRtn2 = 0;

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
        	application.goMain.gfn_POP_resize(this);
        	
        	this.preDate = this.gfn_Today();
        	
        	//클레임 유형
        	this.fn_common_code("C05", "", "");	
        	this.ds_claimTypeCd.copyData(application.gds_common_code);
        	
        	//요청사항
        	this.fn_common_code("C02", "", "");	
        	this.ds_processTypeCd.copyData(application.gds_common_code);	
        	
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.reqQty = this.arg[0];
        	this.ctClaimKind = this.arg[1];
        	this.reqKind = this.arg[2];
        	this.claimMemo = this.arg[3];
        	this.reqDate = this.arg[4];
        	this.reqTime = this.arg[5];
        	this.etcMemo = this.arg[6];
        	
        	this.edt_reqQty.set_value(this.arg[0]);
         	this.cbo_ctClaimKind.set_value(this.arg[1]);
         	this.cbo_reqKind.set_value(this.arg[2]);
         	this.txt_claimMemo.set_value(this.arg[3]);
         	this.cal_reqDate.set_value(this.arg[4]);
        	this.msk_reqTime.set_value(this.arg[5]);
        	this.txt_etcMemo.set_value(this.arg[6]);
        	this.msk_dlvyQty.set_value(this.arg[7]);
        	
        	var nRow = this.ds_list.addRow();
        	this.ds_list.setColumn(nRow, "checked", "1");
        	this.ds_list.setColumn(nRow, "reqQty", this.arg[0]);
        	this.ds_list.setColumn(nRow, "poId", this.arg[8]);
        	this.ds_list.setColumn(nRow, "poNum", this.arg[9]);
        	//this.fn_chk();
        	
        	var values = this.cbo_reqKind.value;
        	if(values == "C0203" || values == "C0204")
        	{	
        		this.msk_reqTime.set_enable(true);
        	}
        	else
        	{
        		this.msk_reqTime.set_enable(false);
        	}	
        	
        	this.edt_reqQty.setFocus();
        	this.edt_reqQty.setSelect(this.edt_reqQty.text.length, this.edt_reqQty.text.length);
        }

        // 달력 클릭 시(From)
        this.sta_reqDate_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_reqDate.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        //클레임유형  콤보 팝업창 호출
        this.cbo_claimType_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_claimTypeCd;
        	arg[1] = "클레임유형";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("ClaimType", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //요청사항  콤보 팝업창 호출
        this.cbo_processType_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_processTypeCd;
        	arg[1] = "요청사항";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("ProcessType", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  저장버튼 클릭시
        * 설      명   :  저장버튼 클릭시
        ********************************************************************************/ 
        this.btn_save_onclick = function(obj,e)
        {
        	//저장 체크
         	if(!this.fn_SaveCheck())
        	{
        		return;
        	}
        	//this.fn_chk();
        	this.fn_save();
        }

        this.fn_save = function ()
        {
        	var arg = new Array();
        	
        	arg[0] = this.edt_reqQty.value;     							 //요청수량
        	arg[1] = this.ds_claimTypeCd.getColumn(this.vRtn, "cd"); 		 //클레임유형
        	arg[2] = this.ds_processTypeCd.getColumn(this.vRtn2, "cd");      //요청사항
        	arg[3] = this.txt_claimMemo.text;    							 //클레임상세내용
        	arg[4] = this.cal_reqDate.value;    							 //입고요청일자
        	arg[5] = this.msk_reqTime.value;     							 //입고요청시간
        	arg[6] = this.txt_etcMemo.text;      							 //기타사항
        	
        	application.goMain.gfn_POP_close(this, arg);
        }

        /*******************************************************************************
        * 기      능   :  저장체크
        * 설      명   :  저장체크
        ********************************************************************************/
        this.fn_chk = function ()
        {
        	this.ds_list.setColumn(0, "reqQty", this.edt_reqQty.value);
        	
        	this.ds_list.setRowType(0 , "U");
        	
        	var strSvcID   		 = "claimQty";
        	var strUrl     		 = "fm/fmc/claimReg/selectItemQty.xdo";
        	var strInDataset     = "ds_list=ds_list:U";
        	var strOutDataset    = "ds_listqty=ds_listqty";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*******************************************************************************
        * 기      능   :  저장체크
        * 설      명   :  저장체크
        ********************************************************************************/
        this.fn_SaveCheck = function ()
        {
        	if ( this.gfn_isNull(this.edt_reqQty.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "요청량을 입력하세요.", "OK", true, this);
        		return false;
        	}	 	
         	
         	if( this.gfn_isNull(this.cbo_ctClaimKind.value) )
         	{
         		application.goMain.gfn_Msg("ALERT_0", "알림", "클레임유형를 입력하세요.", "OK");	
         		return false;
         	}
         	
         	if ( this.gfn_isNull(this.cbo_reqKind.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "요청사항을 입력하세요.", "OK", true, this);
        		return false;
        	}
        		
        	if ( this.gfn_isNull(this.txt_claimMemo.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "클레임상세내용을 입력하세요.", "OK", true, this);
        		return false;
        	}	
        	
        	var values = this.cbo_reqKind.value;
         	
         	this.preDateTime = this.gfn_subStr(this.gfn_TodayTime(),0,12);  //현재날짜 + 현재시간 + 분
        	this.inputDateTime = this.cal_reqDate.value + this.msk_reqTime.value; //입고요청일자 + 입고요청시간 + 분
        	
        	if(values == "C0203" || values == "C0204")
        	{	
        		if ( this.gfn_isNull(this.cal_reqDate.value) )
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "입고요청일자를 입력하세요.", "OK", true, this);
        			return false;
        		} 	
         	
        		if ( this.gfn_isNull(this.gfn_Ltrim(this.msk_reqTime.value)) )
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "교환일경우 입고요청시간을 입력하셔야 합니다.", "OK", true, this);
        			return false;
        		}
        		
        		if(!this.gfn_IsTime(this.msk_reqTime.value + "00")) 
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "시간 형식에서 벗어났습니다.", "OK", true, this);
        			this.msk_reqTime.set_value(this.arg[5]);
        			return false;
        		}
        		
        		if(nexacro.toNumber(this.inputDateTime) < nexacro.toNumber(this.preDateTime))
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "입고요청일자 및 시간은 현재날짜 및 현재시간 이전일수 없습니다!", "OK", true, this);
        			return false;
        		}
        	}
        	else
        	{
        		if ( !this.gfn_isNull(this.cal_reqDate.value) )
        		{
        			if(nexacro.toNumber(this.cal_reqDate.value) < nexacro.toNumber(this.preDate))
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "입고요청일자는 현재날짜 이전일수 없습니다!", "OK", true, this);
        				return false;
        			}
        		}	
        		
        	}		
        	
        	var reqQty = new Number(this.edt_reqQty.value);
        	var dlvyQty = new Number(this.msk_dlvyQty.value);

        	if(reqQty > dlvyQty)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "요청량이 입고수량보다 큽니다.", "OK", true, this);
        		return false;
        	}	
        		
        // 	if(this.ds_listqty.getRowCount() > 0){
        // 		if(this.ds_listqty.getColumn(0,"claimQty") == "N"){
        // 			var msg = "["+this.ds_listqty.getColumn(0,"upjangnm")+"]업장에 ["+this.ds_listqty.getColumn(0,"itemName") +"]는\n";
        // 			application.goMain.gfn_Msg("ALERT_0", "알림", msg+"재고부족으로 클레임 요청을 하실 수 없습니다.", "OK", true, this);
        // 			return false;			
        // 		}		
        // 	}
        	
        	if(this.reqQty == this.edt_reqQty.value && this.ctClaimKind == this.cbo_ctClaimKind.value && this.reqKind == this.cbo_reqKind.value && this.claimMemo == this.txt_claimMemo.value && 
        	   this.reqDate == this.cal_reqDate.value && this.reqTime == this.msk_reqTime.value && this.etcMemo == this.txt_etcMemo.value)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK", true, this);
        		return false;
        	}
        	
        	
        	return true;
        }

        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		application.goMain.gfn_POP_close(this, "CLOSEONLY");		
        	}
        	
            switch(strSvcID)
            {
        		case "claimQty" :
        			this.fn_save();
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
        		case "PopCalFrom":
        			this.cal_reqDate.set_value(rtn);
        			break;
        		case "ClaimType":
        			this.cbo_ctClaimKind.set_index(rtn);
        			this.vRtn = rtn;
        			
        			var ctClaimKind = this.cbo_ctClaimKind.value;
        			//업체주의요청_클레임유형이 업체 주의요청일 경우 양쪽 모두(업체주의요청) 셋팅
        			if(ctClaimKind == "C0519")
        			{	
        				var nIndex1 = this.ds_processTypeCd.findRowExpr("cd=='C0206'");
        				this.cbo_reqKind.set_index(nIndex1);	
        				this.vRtn2 = nIndex1;
        			}	
        			
        			break;	
        		case "ProcessType":
        			this.cbo_reqKind.set_index(rtn);
        			this.vRtn2 = rtn;
        			
        			var values = this.cbo_reqKind.value;
        			if(values == "C0203" || values == "C0204")
        			{	
        				this.msk_reqTime.set_enable(true);
        			}
        			else
        			{
        				this.msk_reqTime.set_enable(false);
        			}
        			
        			//업체주의요청_요청사항이 업체 주의요청일 경우 양쪽 모두(업체주의요청) 셋팅
        			if(values == "C0206")
        			{		
        				var nIndex2 = this.ds_claimTypeCd.findRowExpr("cd=='C0519'");
        				this.cbo_ctClaimKind.set_index(nIndex2);	
        				this.vRtn = nIndex2;
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
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_listqty.addEventHandler("oncolumnchanged", this.ds_list_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.cbo_ctClaimKind.addEventHandler("ondropdown", this.cbo_claimType_ondropdown, this);
            this.cbo_reqKind.addEventHandler("ondropdown", this.cbo_processType_ondropdown, this);
            this.msk_reqTime.addEventHandler("oneditclick", this.msk_reqTime_oneditclick, this);
            this.btn_save.addEventHandler("onclick", this.btn_save_onclick, this);
            this.sta_reqDate.addEventHandler("onclick", this.sta_reqDate_onclick, this);

        };

        this.loadIncludeScript("ClaimProcessDetailReqtPop.xfdl", true);

       
    };
}
)();
