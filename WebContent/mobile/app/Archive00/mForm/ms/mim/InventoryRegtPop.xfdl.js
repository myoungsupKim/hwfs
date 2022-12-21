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
                this.set_name("InventoryRegtPop");
                this.set_titletext("재고상세등록");
                this._setFormPosition(0,0,420,275);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "274", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "135", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "136", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "254", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "197", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_insert", "absolute", "345", "207", "65", "47", null, null, this);
            obj.set_taborder("2");
            obj.set_text("입력");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "12", "80", null, "59", "11", null, this);
            obj.set_taborder("72");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("74");
            obj.set_text("상세등록");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "12", "138", null, "59", "11", null, this);
            obj.set_taborder("75");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "135", "144", "275", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("76");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Static("Static05", "absolute", "0", "80", "156", "59", null, null, this);
            obj.set_taborder("77");
            obj.set_text("실사량");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "139", "156", "59", null, null, this);
            obj.set_taborder("78");
            obj.set_text("유통기한");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "135", "144", "275", "47", null, null, this);
            obj.set_taborder("1");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_mRealQty", "absolute", "520", "88", "275", "45", null, null, this);
            obj.set_taborder("80");
            obj.set_type("number");
            obj.set_mask("#,##0.#0");
            obj.set_autoselect("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_mRealQty", "absolute", "135", "85", "275", "47", null, null, this);
            obj.set_taborder("0");
            obj.set_inputtype("number,dot");
            obj.style.set_align("right middle");
            obj.set_autoselect("false");
            obj.set_displaynulltext("수량을 입력하세요");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 275, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("재고상세등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("InventoryRegtPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("InventoryRegtPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		수량등록
        // [부시스템명]	수량등록 팝업 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;

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
        this.AppDetailReqtPop_onload = function(obj,e)
        {
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.edt_mRealQty.set_value(this.arg[0]);
        	this.cal_dtFrom.set_value(this.arg[1]);
        	
        	application.goMain.gfn_POP_resize(this);
        	
        	if(this.edt_mRealQty.value == 0)
        	{	
        		this.edt_mRealQty.set_value("");
        		this.edt_mRealQty.setFocus();	
        	}	
        	else
        	{
        		this.edt_mRealQty.setFocus();
        		this.edt_mRealQty.setSelect(this.edt_mRealQty.text.length, this.edt_mRealQty.text.length);
        	}	
        }

        //닫기 버튼 클릭시
        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        //입력 버튼 클릭시
        this.btn_insert_onclick = function(obj,e)
        {

        	if (this.gfn_isNull(this.edt_mRealQty.value)){
        		application.goMain.gfn_Msg("OK", "알림", "실사량을 입력하세요.", "OK", "OK");
                return;		
        	}
        	
        	if (this.gfn_isNull(this.cal_dtFrom.value)){
        		application.goMain.gfn_Msg("OK", "알림", "유통기한을 입력하세요.", "OK", "OK");
                return;		
        	}
        	
        	if(this.edt_mRealQty.value <= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "실사량은 '0'보다 커야 합니다.", "OK");
        		this.edt_mRealQty.set_value(0);
        		return;			
        	}
        	
        	var arg = new Array();
        	arg[0] = this.gfn_ToFixed(this.edt_mRealQty.value, 2);  // 실사량
        	arg[1] = this.cal_dtFrom.value;    // 유통기한	
        	
        	application.goMain.gfn_POP_close(this, arg);
        	
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
        			this.cal_dtFrom.set_value(rtn);
        			break;					
        	}
        }

        this.edt_mRealQty_onchar = function(obj,e)
        {
        	var nVal = nexacro.replaceAll(e.posttext, ",", "");
        	var nidx = nVal.indexOf(".");
        	
        	if(nidx > -1)
        	{
        		nVal = nVal.substr(0, nidx);
        	}
        	
        	if(nVal.length > 4)
        	{
        		return false;
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.AppDetailReqtPop_onload, this);
            this.btn_insert.addEventHandler("onclick", this.btn_insert_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.msk_mRealQty.addEventHandler("onchar", this.msk_mRealQty_onchar, this);
            this.edt_mRealQty.addEventHandler("onchar", this.edt_mRealQty_onchar, this);

        };

        this.loadIncludeScript("InventoryRegtPop.xfdl", true);

       
    };
}
)();
