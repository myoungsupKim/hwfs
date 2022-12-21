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
                this.set_name("CmmnSetDayPop");
                this.set_titletext("기간설정(일)");
                this.set_scrollbars("autohorz");
                this._setFormPosition(0,0,455,375);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "455", "375", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staFromToBg", "absolute", "10", "229", "435", "59", null, null, this);
            obj.set_taborder("21");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "455", "70", null, null, this);
            obj.set_taborder("22");
            obj.set_text("기간설정");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "458", "49", "45", "25", null, null, this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_R_FlagLine");
            this.addChild(obj.name, obj);

            obj = new Button("btnComplete", "absolute", "310", "308", "65", "47", null, null, this);
            obj.set_taborder("29");
            obj.set_text("적용");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnCancel", "absolute", "380", "308", "65", "47", null, null, this);
            obj.set_taborder("30");
            obj.set_text("취소");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnToDay", "absolute", "86", "110", "91", "47", null, null, this);
            obj.set_taborder("31");
            obj.set_text("당일");
            obj.set_cssclass("btn_cal_term");
            this.addChild(obj.name, obj);

            obj = new Button("btnOneWeek", "absolute", "182", "110", "91", "47", null, null, this);
            obj.set_taborder("32");
            obj.set_text("1주일");
            obj.set_cssclass("btn_cal_term");
            this.addChild(obj.name, obj);

            obj = new Button("btnOneMonth", "absolute", "278", "110", "91", "47", null, null, this);
            obj.set_taborder("33");
            obj.set_text("1개월");
            obj.set_cssclass("btn_cal_term");
            this.addChild(obj.name, obj);

            obj = new Calendar("calApplyDtFr", "absolute", "20", "235", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("34");
            obj.set_dateformat("yyyy.MM.dd");
            obj.set_editformat("yyyy.MM.dd");
            obj.set_value("null");
            obj.set_readonly("true");

            obj = new Static("staFromTo", "absolute", "220", "235", "20", "47", null, null, this);
            obj.set_taborder("35");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("calApplyDtTo", "absolute", "240", "235", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("36");
            obj.set_dateformat("yyyy.MM.dd");
            obj.set_editformat("yyyy.MM.dd");
            obj.set_value("null");
            obj.set_readonly("true");

            obj = new Button("btnThreeMonth", "absolute", "134", "162", "91", "47", null, null, this);
            obj.set_taborder("37");
            obj.set_text("3개월");
            obj.set_cssclass("btn_cal_term");
            this.addChild(obj.name, obj);

            obj = new Button("btnSixMonth", "absolute", "230", "162", "91", "47", null, null, this);
            obj.set_taborder("38");
            obj.set_text("6개월");
            obj.set_cssclass("btn_cal_term");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", "400", "0", null, "67", "0", null, this);
            obj.set_taborder("49");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "385", "0", "70", "70", null, null, this);
            obj.set_taborder("48");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 455, 375, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("ComTabMenu");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("기간설정(일)");
            		p.set_scrollbars("autohorz");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnSetDayPop.xfdl", "lib::lib_Date.xjs");
        this.registerScript("CmmnSetDayPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 > 기간설정(일)
        // [부시스템명]	공통 > 기간설정(일)
        // [설명]
        // 		공통 > 기간설정(일) from ~ to 화면에 셋팅
        // [작성자명] 		투비소프트
        // [작성일자]		2014.08.18
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 홍길동 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/

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
        this.CmmnSetDayPop_onload = function(obj,e)
        {
        	var arg = application.goMain.gfn_POP_getArg();
        	application.goMain.gfn_POP_resize(this);
        	
        	//당일 셋팅 
        	//var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(arg[0]);
        	this.calApplyDtTo.set_value(arg[1]);
        }

        this.calApplyDtFr_ontouchstart = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }
        // this.calApplyDtTo_ondropdown = function(obj:Calendar, e:nexacro.EventInfo)
        // {
        // 	var objCalArg = obj.value;
        // 	
        // 	application.goMain.gfn_POP_create("PopCalTo", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        // 	return false;
        // }
        this.calApplyDtTo_ontouchstart = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalTo", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        
        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/
        /** 
         * 테이터셋셋팅
         * @param  
        	value  : 셋팅값
         * @return : 없음
         */

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/

        /** 
         * 확인버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnComplete_onclick = function(obj,e)
        {
        	if (application.gfn_IsNull(this.calApplyDtFr.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "기간을 선택해 주세요.", "OK", true, this);
        		return;	
        	}
        	if (application.gfn_IsNull(this.calApplyDtFr.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "기간을 선택해 주세요.", "OK", true, this);
        		return;	
        	}

        	var arg = new Array();
        	arg[0] = this.calApplyDtFr.value;	//from
        	arg[1] = this.calApplyDtTo.value;	//to

        	//팝업을 닫으면서 dataset 을 넘김.
        	application.goMain.gfn_POP_close(this, arg);

        }

        /** 
         * 취소버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staBtnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.btnCancel_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        //당일
        this.btnToDay_onclick = function(obj,e)
        {
        	//당일 셋팅 
        	var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(sToday);
        	this.calApplyDtTo.set_value(sToday);
        }

        //1주일
        this.btnOneWeek_onclick = function(obj,e)
        { 
        	var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(this.gfn_AddDate(sToday, -7));
        	this.calApplyDtTo.set_value(sToday);
        }

        //1개월
        this.btnOneMonth_onclick = function(obj,e)
        {
        	var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(this.gfn_AddMonth(sToday, -1));
        	this.calApplyDtTo.set_value(sToday);
        }

        //3개월
        this.btnThreeMonth_onclick = function(obj,e)
        {
        	var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(this.gfn_AddMonth(sToday, -3));
        	this.calApplyDtTo.set_value(sToday);
        }

        //6개월
        this.btnSixMonth_onclick = function(obj,e)
        {
        	var sToday = this.gfn_Today();
        	this.calApplyDtFr.set_value(this.gfn_AddMonth(sToday, -6));
        	this.calApplyDtTo.set_value(sToday);	
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
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
        		//신청일 from
        		case "PopCalFrom":				
        			this.calApplyDtFr.set_value(rtn);
        			break;
        		//신청일 to
        		case "PopCalTo":				
        			this.calApplyDtTo.set_value(rtn);
        			break;
        	}
        }

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnSetDayPop_onload, this);
            this.btnComplete.addEventHandler("onclick", this.btnComplete_onclick, this);
            this.btnCancel.addEventHandler("onclick", this.btnCancel_onclick, this);
            this.btnToDay.addEventHandler("onclick", this.btnToDay_onclick, this);
            this.btnOneWeek.addEventHandler("onclick", this.btnOneWeek_onclick, this);
            this.btnOneMonth.addEventHandler("onclick", this.btnOneMonth_onclick, this);
            this.calApplyDtFr.addEventHandler("onlbuttonup", this.calApplyDtFr_onlbuttonup, this);
            this.calApplyDtFr.addEventHandler("ontouchstart", this.calApplyDtFr_ontouchstart, this);
            this.calApplyDtTo.addEventHandler("ontouchstart", this.calApplyDtTo_ontouchstart, this);
            this.btnThreeMonth.addEventHandler("onclick", this.btnThreeMonth_onclick, this);
            this.btnSixMonth.addEventHandler("onclick", this.btnSixMonth_onclick, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("CmmnSetDayPop.xfdl", true);

       
    };
}
)();
