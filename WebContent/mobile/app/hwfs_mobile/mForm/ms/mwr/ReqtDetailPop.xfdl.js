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
                this.set_name("ReqtDetailPop");
                this.set_titletext("상세등록");
                this._setFormPosition(0,0,420,567);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_reservCd", this);
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

            obj = new Dataset("ds_timeCd", this);
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


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "566", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("상세등록");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "376", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "192", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "547", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "490", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save", "absolute", "345", "500", "65", "47", null, null, this);
            obj.set_taborder("7");
            obj.set_text("등록");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "12", "186", null, "59", "11", null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_regNm", "absolute", "9", "192", "260", "47", null, null, this);
            obj.set_taborder("2");
            obj.set_displaynulltext("예약자명을 입력");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "12", "244", null, "59", "11", null, this);
            obj.set_taborder("75");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_phoneNumber", "absolute", "9", "250", "401", "47", null, null, this);
            obj.set_taborder("4");
            obj.set_displaynulltext("핸드폰 번호를 입력");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "12", "302", null, "59", "11", null, this);
            obj.set_taborder("77");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new TextArea("txt_remark", "absolute", "10", "367", "400", "123", null, null, this);
            obj.set_taborder("6");
            obj.set_displaynulltext("내용 입력");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "11", "128", null, "59", "12", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "11", "70", null, "59", "12", null, this);
            obj.set_taborder("83");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_eventNm", "absolute", "9", "134", "401", "47", null, null, this);
            obj.set_taborder("1");
            obj.set_displaynulltext("행사명을 입력");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_reservCd", "absolute", "10", "76", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("0");
            obj.set_displaynulltext("행사종류 선택");
            obj.set_innerdataset("@ds_reservCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Edit("edt_psn", "absolute", "275", "192", "135", "47", null, null, this);
            obj.set_taborder("3");
            obj.set_displaynulltext("인원");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_time", "absolute", "220", "308", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("5");
            obj.set_innerdataset("@ds_timeCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Static("Static34", "absolute", "198", "308", "15", "47", null, null, this);
            obj.set_taborder("89");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_startTime", "absolute", "9", "308", "180", "47", null, null, this);
            obj.set_taborder("90");
            obj.style.set_align("center middle");
            obj.set_enable("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 567, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상세등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ReqtDetailPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ReqtDetailPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		가계약상세등록
        // [부시스템명]	가계약상세등록 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.09
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.09 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.time = undefined;
        this.vRtn = 0;
        this.vRtn2 = 0;
        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        this.AppDetailReqtPop_onload = function(obj,e)
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	application.gds_common_code.clearData();
        	this.fn_common_code("BMS_0005", "", "");	
        	this.ds_reservCd.copyData(application.gds_common_code);	
        	
        	this.fn_common_code("BMS_0015", "", "");	
        	this.ds_timeCd.copyData(application.gds_common_code);	
        	
        	//행사구분이 웨딩일경우 행사종류를 '결혼식'으로 고정
        	if(this.arg[2] == "2")
        	{
        		this.cbo_reservCd.set_enable(false);
        		this.vRtn = this.ds_reservCd.findRowExpr("cd=='2020'");
        		this.cbo_reservCd.set_index(this.vRtn);	
        	}
        	else
        	{
        		this.cbo_reservCd.set_enable(true);
        	}
        	
        	this.edt_startTime.set_value(this.arg[0]);
        	
        	application.goMain.gfn_POP_resize(this);
        }

        
        //닫기버튼 클릭 시
        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        //행사구분 콤보조회 검색 팝업
        this.cbo_event_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_reservCd;
        	arg[1] = "조회조건(행사)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("reservCd", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        this.cbo_hour_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_timeCd;
        	arg[1] = "시간";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("time", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //등록버튼 클릭시
        this.btn_save_onclick = function(obj,e)
        {
        	this.time = this.cbo_time.text;
        	
        	if (this.gfn_isNull(this.cbo_reservCd.value)){
        		application.goMain.gfn_Msg("", "알림", "행사종류룰 선택하세요.", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.edt_eventNm.value)){
        		application.goMain.gfn_Msg("", "알림", "행사명을 입력하세요.", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.edt_regNm.value)){
        		application.goMain.gfn_Msg("", "알림", "예약자명을 입력하세요.", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.edt_psn.value)){
        		application.goMain.gfn_Msg("", "알림", "인원을 입력하세요.", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.edt_phoneNumber.value)){
        		application.goMain.gfn_Msg("", "알림", "핸드폰번호를 입력하세요.", "OK");
                return;		
        	}	
        	
        	if (this.gfn_isNull(this.cbo_time.text)){
        		application.goMain.gfn_Msg("", "알림", "종료시간을 입력하세요.", "OK");
                return;		
        	}	
        	
        	if ( this.edt_startTime.value > this.time.replace(":","") )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "시작시간보다 종료시간이 늦습니다.", "OK");
        		return true;		
        	}
        	
        	if (this.gfn_isNull(this.txt_remark.value)){
        		application.goMain.gfn_Msg("", "알림", "내용을 입력하세요.", "OK");
                return;		
        	}
        	
        	var regNm = this.edt_regNm.value;
        	
        	application.goMain.gfn_Msg("detailRgst", "등록확인","["+regNm+"] 고객님 신청하시겠습니까?", "YN", true, this);
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
        	if (id == "detailRgst")
        	{
        		if (rtn == "Y") 
        		{
        			var arg = new Array();			
        			arg[0] = this.ds_reservCd.getColumn(this.vRtn, "cd");    //행사종류
        			arg[1] = this.edt_eventNm.text; 	                     //행사명
        			arg[2] = this.edt_regNm.text;                            //예약자명
        			arg[3] = this.edt_phoneNumber.value;                     //핸드폰번호
        			arg[5] = this.ds_timeCd.getColumn(this.vRtn2, "cd");     //종료시간
        			arg[6] = this.txt_remark.text;                           //추가내용
        			arg[7] = this.edt_psn.value;                             //인원
        			
        			application.goMain.gfn_POP_close(this, arg);
        		}
        		else
        		{
        			return;
        		}
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
        		case "reservCd":
        			this.cbo_reservCd.set_index(rtn);
        			this.vRtn = rtn;
        			break;	
        		case "time":
        			this.cbo_time.set_index(rtn);
        			this.vRtn2 = rtn;
        			break;	
        		
        	}
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.AppDetailReqtPop_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_save.addEventHandler("onclick", this.btn_save_onclick, this);
            this.edt_regNm.addEventHandler("oneditclick", this.edt_name_oneditclick, this);
            this.edt_phoneNumber.addEventHandler("oneditclick", this.edt_name_oneditclick, this);
            this.cbo_reservCd.addEventHandler("ondropdown", this.cbo_event_ondropdown, this);
            this.edt_psn.addEventHandler("oneditclick", this.edt_name_oneditclick, this);
            this.cbo_time.addEventHandler("ondropdown", this.cbo_hour_ondropdown, this);
            this.edt_startTime.addEventHandler("oneditclick", this.edt_name_oneditclick, this);

        };

        this.loadIncludeScript("ReqtDetailPop.xfdl", true);

       
    };
}
)();
