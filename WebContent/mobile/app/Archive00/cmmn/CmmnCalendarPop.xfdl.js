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
                this.set_name("CmmnCalendarPop");
                this.set_titletext("캘린더");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,670);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "670", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Calendar("calCalendar", "absolute", "10", "80", "500", "580", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("0");
            obj.set_type("monthonly");
            obj.style.set_bordertype("normal 0 0");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("Calendar");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "442", "70", "102", "10", null, null, this);
            obj.set_taborder("8");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "660", "102", "10", null, null, this);
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


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 670, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("캘린더");
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
        this.addIncludeScript("CmmnCalendarPop.xfdl", "lib::lib_Date.xjs");
        this.registerScript("CmmnCalendarPop.xfdl", function(exports) {
        // 1. Calender컴포넌트는 컴포넌트의 위치에 따라 달력이 팝업되기때문에 화면에서 짤리거나 치우치는 문제가 있어
        // 화면 정중앙에 팝업하기 위해 달력화면을 만듬
        // 2. 년월 부분을 선택하면 Spin으로 년월을 변경할 수 있도록 되어 있는 기능을 막기 위해 static컴포넌트를 언저 막음

        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.arg = undefined;
        /*======================================================
         Form 관련 함수
         ======================================================*/
        this.CmmnCalendarPop_onload = function(obj,e)
        {
        // 	if(nexacro.Browser == "MobileSafari")
        // 	{
        // 		this.calCalendar._on_focus = function () {};
        // 	};
        	//trace(" this.preDate >>>>>" +this.preDate);
        	this.fnFormInit();
        }

        this.calCalendar_onchanged = function (obj,e)
        {
        	this.preDate = application.goMain.gfn_POP_getArg();	
        	application.goMain.gfn_POP_close(this, obj.value);
        }

        this.calCalendar_ondayclick = function (obj,e)
        {
        	this.preDate = obj.value;	
        	
        	if (this.preDate == e.date) 
        	{
        		application.goMain.gfn_POP_close(this, obj.value);
        	}
        }
        // coolmind 2012.11.30 - 자주사용하고 화면팝업 속도가 느린 화면을 Main화면에 미리 올려놓고 visible만 변경하는 형태로 팝업(POPDivx) 하려고 하는 화면에서는 반드시 구현해야 하는 함수
        this.fnFormInit = function ()
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.preDate = application.goMain.gfn_POP_getArg();	
        	
        	if (application.gfn_IsNull(this.preDate)) 
        	{
        		this.preDate = this.gfn_Today();
        	}
        	this.calCalendar.set_value(this.preDate);
        	
        	this.calCalendar.set_dateformat("yyyyMMdd");
        	
        	//안드로이드4.3TODO
        	//this.setTimer(1,100);
        	application.goMain.gfn_POP_resize(this);
        }

        //년월선택 시 20141020 추가사항 월력 호출
        this.btnTitle_onclick = function(obj,e)
        {
        	var arg = this.calCalendar.value;
        	application.goMain.gfn_POP_create("PopMonthCal", "cmmn::CmmnCalMonthPop.xfdl", "fn_callbackPOP", this, arg , "POPx", application.goMain.divBase);
        	return false;
        }

        
        //하단 x 버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	var getDate = application.goMain.gfn_POP_getArg();
        	
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.CmmnCalendarPop_ontimer = function(obj,e)
        {
        	this.killTimer(1);
        	application.goMain.gfn_POP_resize(this);
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
        		//월력팝업
        		case "PopMonthCal":
        			var sMonth = rtn+"";
        			if(sMonth.length < 8)
        			{
        				sMonth += "01";
        			}
        			this.preDate = sMonth
        			this.calCalendar.set_value(sMonth);
        			break;			
        	}
        }

        //이전
        this.btnPrev_onclick = function(obj,e)
        {
        	var sMonth = this.gfn_AddMonth(this.preDate, -1);
        	this.preDate = sMonth;
        	this.calCalendar.set_value(this.preDate);
        }

        //다음
        this.btnNext_onclick = function(obj,e)
        {
        	var sMonth = this.gfn_AddMonth(this.preDate, +1);
        	this.preDate = sMonth;
        	this.calCalendar.set_value(this.preDate);
        }

        this.Static05_onclick = function(obj,e)
        {
        	var arg = this.calCalendar.value;
        	application.goMain.gfn_POP_create("PopMonthCal", "cmmn::CmmnCalMonthPop.xfdl", "fn_callbackPOP", this, arg , "POPx", application.goMain.divBase);
        	return false;
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnCalendarPop_onload, this);
            this.addEventHandler("ontimer", this.CmmnCalendarPop_ontimer, this);
            this.calCalendar.addEventHandler("ondayclick", this.calCalendar_ondayclick, this);
            this.calCalendar.addEventHandler("onchanged", this.calCalendar_onchanged, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);

        };

        this.loadIncludeScript("CmmnCalendarPop.xfdl", true);

       
    };
}
)();
