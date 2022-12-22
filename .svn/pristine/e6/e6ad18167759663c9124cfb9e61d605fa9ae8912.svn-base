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
                this.set_name("EfoodistWebzinePdfPop");
                this.set_titletext("PDF미리보기팝업");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,670);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "715", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("PDF미리보기");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "705", "102", "10", null, null, this);
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

            obj = new WebBrowser("WebBrowser", "absolute", "10", "74", "502", "632", null, null, this);
            obj.set_taborder("14");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 670, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("PDF미리보기팝업");
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
        this.addIncludeScript("EfoodistWebzinePdfPop.xfdl", "lib::lib_Date.xjs");
        this.registerScript("EfoodistWebzinePdfPop.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        /*======================================================
         Form 관련 함수
         ======================================================*/
        this.CmmnCalendarPop_onload = function(obj,e)
        {
        	this.fnFormInit();	
        	
        }

        // coolmind 2012.11.30 - 자주사용하고 화면팝업 속도가 느린 화면을 Main화면에 미리 올려놓고 visible만 변경하는 형태로 팝업(POPDivx) 하려고 하는 화면에서는 반드시 구현해야 하는 함수
        this.fnFormInit = function ()
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	// 내장 웹브라우져 컴포넌트 url호출
        	this.WebBrowser.set_url(application.services["svc"].url + "upload/ms/mef/" + this.arg[0]);
        	
        	application.goMain.gfn_POP_resize(this);
        }

        //상단 x 버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this , this.preDate);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnCalendarPop_onload, this);
            this.addEventHandler("ontimer", this.CmmnCalendarPop_ontimer, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);

        };

        this.loadIncludeScript("EfoodistWebzinePdfPop.xfdl", true);

       
    };
}
)();
