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
                this.set_name("AdditionOrderErrorListPop");
                this.set_titletext("불용자재 결과 조회 팝업");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,539);
            }
            this.getSetter("inheritanceid").set("");

            
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
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemVal\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("불용자재 결과 조회");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "528", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "428", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "436", "10", "100", null, null, this);
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

            obj = new Grid("grd_list", "absolute", "0", "72", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("21");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("row");
            obj.set_autosizingtype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"126\"/><Column size=\"394\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"3\"/><Row size=\"50\"/><Row size=\"3\"/><Row size=\"50\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\"/></Band><Band id=\"body\"><Cell colspan=\"2\" style=\"line:0 solid #808080 ;\" autosizerow=\"limitmax\"/><Cell row=\"1\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left bottom;padding:5 10 5 10;line:0 none #808080ff ;color:blue;color2:blue;selectcolor:blue;\" text=\"bind:ITEM_CODE\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left bottom;padding:5 10 5 10;line:0 none #808080ff ;\" text=\"bind:ITEM_NAME\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" colspan=\"2\" style=\"line:0 solid #808080ff ;\" autosizerow=\"limitmax\"/><Cell row=\"3\" colspan=\"2\" style=\"align:left top;padding:5 10 5 10;line:0 solid #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:ITEM_VAL\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" colspan=\"2\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 539, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("불용자재 결과 조회 팝업");
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
        this.addIncludeScript("AdditionOrderErrorListPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AdditionOrderErrorListPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		담보현황팝업
        // [부시스템명]	담보현황팝업
        // [설명]		    담보현황팝업.
        // [작성자명] 		강대성
        // [작성일자]		2015.07.31
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.26 : 강대성 : 담보현황팝업 신규
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
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
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	application.goMain.gfn_POP_resize(this);
        	
        	// 데이터셋 카피
        	this.ds_grd.copyData(application.goMenu.ds_save_out, true);	
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
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);

        };

        this.loadIncludeScript("AdditionOrderErrorListPop.xfdl", true);

       
    };
}
)();
